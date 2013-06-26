GRANT USAGE ON *.* TO 'mipt_test'@'localhost';
DROP USER 'mipt_test'@'localhost';
CREATE USER 'mipt_test'@'localhost' IDENTIFIED BY 'juOkewOP43uo';
GRANT SELECT ON TABLE mipt_test.* TO 'mipt_test'@'localhost';

GRANT USAGE ON *.* TO 'mipt'@'localhost';
DROP USER 'mipt'@'localhost';
CREATE USER 'mipt'@'localhost' IDENTIFIED BY 'uiY452utqNMM';
GRANT CREATE, DROP, ALTER, DELETE, INDEX, UPDATE, SELECT, INSERT, TRIGGER ON TABLE mipt.* TO 'mipt'@'localhost';
GRANT CREATE, DROP, ALTER, DELETE, INDEX, UPDATE, SELECT, INSERT, TRIGGER ON TABLE mipt_test.* TO 'mipt'@'localhost';
GRANT CREATE, DROP, ALTER, DELETE, INDEX, UPDATE, SELECT, INSERT, TRIGGER ON TABLE mipt_stable.* TO 'mipt'@'localhost';

GRANT USAGE ON *.* TO 'mipt_stable'@'localhost';
DROP USER 'mipt_stable'@'localhost';
CREATE USER 'mipt_stable'@'localhost' IDENTIFIED BY 'qwerMH782hj';
GRANT CREATE, DROP, ALTER, DELETE, INSERT, SELECT, UPDATE ON TABLE mipt_stable.* TO 'mipt_stable'@'localhost';
