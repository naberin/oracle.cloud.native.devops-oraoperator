-- Copyright (c) 2022 Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

create table bankbuser.accounts (
  accountid integer PRIMARY KEY NOT NULL,
  accountvalue integer CONSTRAINT positive_inventory CHECK (accountvalue >= 0) );

insert into bankbuser.accounts values (100, 100);
insert into bankbuser.accounts values (200, 200);
insert into bankbuser.accounts values (300, 300);