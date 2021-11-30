#! /bin/bash

set -e

createdb federation_sample

psql federation_sample -e <<-EOS
  CREATE TABLE people (id character varying, name character varying, domain character varying);
  INSERT INTO people (id, name, domain) VALUES 
    ('GBW63SL3JHECAFJAGOCYFHL4D5ZQ6OVMVV5E7WPTSXKUGQ6TRT2J3IMY', 'megha', 'digitalbits.io'),
    ('GBAZNR56HF33YM46Z4RD23LYIK3MJRDCAJ5MZAECRLHHWWXNY23ECZBL', 'raj', 'digitalbits.io');
EOS