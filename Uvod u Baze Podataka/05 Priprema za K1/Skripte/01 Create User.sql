--------------------------------------------------------------------
-- execute the following statements to create a user name OT and
-- grant priviledges
--------------------------------------------------------------------

-- create new user
CREATE USER OT IDENTIFIED BY yourpassword;

-- grant priviledges
GRANT CONNECT, RESOURCE, DBA TO OT;