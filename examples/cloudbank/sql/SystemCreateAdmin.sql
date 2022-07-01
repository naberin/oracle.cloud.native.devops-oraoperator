-- Copyright (c) 2022 Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

CREATE USER ADMIN IDENTIFIED BY Welcome12345;
GRANT unlimited tablespace to ADMIN;
GRANT connect, resource TO AQUSER;