## Federation server

We have used the Go implementation of [Federation](https://developer.digitalbits.io/learn/concepts/federation.html) protocol server configured to pull the data it needs out of our database.

### Config

By default this server uses a config file named `federation.cfg` in the current working directory. This configuration file should be [TOML](https://github.com/toml-lang/toml) and the following fields are supported:

* `port` - server listening port
* `database`
  * `type` - database type (sqlite3, mysql, postgres)
  * `dsn` - The DSN (data source name) used to connect to the database connection.  This value should be appropriate for the database type chosen.
    * for `mysql`: `user:password@(host:port)/dbname` ([more info](https://github.com/go-sql-driver/mysql#dsn-data-source-name))
    * for `postgres`: `postgres://user:password@host/dbname?sslmode=sslmode` ([more info](https://godoc.org/github.com/lib/pq#hdr-Connection_String_Parameters))
* `queries`
  * `federation` - Implementation dependent query to fetch federation results, should return either 1 or 3 columns. These columns should be labeled `id`,`memo`,`memo_type`. Memo and memo_type are optional - see [Federation](https://developer.digitalbits.io/learn/concepts/federation.html) docs for more detail).  When executed, this query will be provided with two input parameters, the first will be the name portion of a DigitalBits address and the second will be the domain portion of a DigitalBits address.  For example, a request for `tom*digitalbits.io` would trigger a query with two input parameters, `tom` and `digitalbits.io` respectively. 
  * `reverse-federation` - A SQL query to fetch reverse federation results that should return two columns, labeled `name` and `domain`.   When executed, this query will be provided with one input parameter, a [DigitalBits account ID](https://developer.digitalbits.io/guides/concepts/accounts.html#account-id) used to lookup the name and domain mapping.

    If reverse-lookup isn't supported (e.g. you have a single DigitalBits account for all users), leave this entry out.

* `tls` (only when running HTTPS server)
  * `certificate-file` - a file containing a certificate
  * `private-key-file` - a file containing a matching private key

`memo_type` should be one of the following:
* `id` - then `memo` field should contain unsigned 64-bit integer, please note that this value will be converted to integer so the field should be an integer or a string representing an integer,
* `text` - then `memo` field should contain string, up to 28 characters.
* `hash` - then `memo` field should contain string that is 32bytes base64 encoded.

#### #1: Every user has their own DigitalBits account

In the case that every user owns a DigitalBits account, you don't need `memo`. You can simply return `id` based on the username. Your `queries` section could look like this:

```toml
port = 8000

[database]
type = "mysql"
dsn = "dbuser:dbpassword@/dbname"

[queries]
federation = "SELECT account_id as id FROM Users WHERE username = ? AND domain = ?"
reverse-federation = "SELECT username as name, domain FROM Users WHERE account_id = ?"
```


#### #2: Single DigitalBits account for all incoming transactions

If you have a single DigitalBits account for all incoming transactions you need to use `memo` to check which internal account should receive the payment.

Let's say that your DigitalBits account ID is: `GD6WU64OEP5C4LRBH6NK3MHYIA2ADN6K6II6EXPNVUR3ERBXT4AN4ACD` and every user has an `id` and `username` in your database. Then your `queries` section could look like this:

```toml
port = 8000

[database]
type = "mysql"
dsn = "dbuser:dbpassword@/dbname"

[queries]
federation = "SELECT username as memo, 'text' as memo_type, 'GD6WU64OEP5C4LRBH6NK3MHYIA2ADN6K6II6EXPNVUR3ERBXT4AN4ACD' as id FROM Users WHERE username = ? AND domain = ?"
# No entry for `reverse-federation` since a reverse-lookup isn't possible
```

##### Providing federation for a single domain

In the event we want to offer federation for a single domain, a little bit of trickery can be used to configure the queries to satisfy this use case.

```toml
federation = "SELECT username as memo, 'text' as memo_type, 'GD6WU64OEP5C4LRBH6NK3MHYIA2ADN6K6II6EXPNVUR3ERBXT4AN4ACD' as id FROM Users WHERE username = ? AND ? = 'tricemix.com'"
reverse-federation = "SELECT username as name, 'tricemix.com' as domain FROM Users WHERE account_id = ?"
```

Notice that SQL fragment `? = 'tricemix.com"` on the `federation` query:  It ensures the incoming query is for the correct domain.  Additionally, the `reverse-federation` query always returns `tricemix.com` for the domain.

#### Running

```
./federation [-c=CONFIGPATH]
```