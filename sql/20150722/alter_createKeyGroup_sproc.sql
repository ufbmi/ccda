DELIMITER ;;
CREATE PROCEDURE `createKeyGroup_adminer_55b00388b299c` (IN `key_count` int, IN `min_val` int)
BEGIN
    DECLARE i INT;
    SET i = 0;
    START TRANSACTION;
        WHILE i <= key_count DO
            CALL insertSessionKey(min_val + i);
            SET i = i + 1;
        END WHILE;
    COMMIT;
END;;
DELIMITER ;
DROP PROCEDURE `createKeyGroup_adminer_55b00388b299c`;
DROP PROCEDURE `createKeyGroup`;
DELIMITER ;;
CREATE PROCEDURE `createKeyGroup` (IN `key_count` int, IN `min_val` int)
BEGIN
    DECLARE i INT;
    SET i = 0;
    START TRANSACTION;
        WHILE i <= key_count DO
            CALL insertSessionKey(min_val + i);
            SET i = i + 1;
        END WHILE;
    COMMIT;
END;;
DELIMITER ;
