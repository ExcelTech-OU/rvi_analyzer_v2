CREATE DATABASE achilies;

use achilies;

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    email VARCHAR(128) NOT NULL,
    username VARCHAR(64) NOT NULL,
    password VARCHAR(256) NOT NULL,
    age INT DEFAULT 0,
    occupation VARCHAR(64) DEFAULT NULL,
    user_condition VARCHAR(128) DEFAULT NULL,
    role_id INT DEFAULT 2,
    password_reset_pin INT DEFAULT 0,
    is_pin_validated TINYINT(1) DEFAULT true,
    enabled TINYINT(1) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE device (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    mac_address VARCHAR(128) NOT NULL,
    batch_no VARCHAR(64) NOT NULL,
    firmware_version VARCHAR(64) NOT NULL,
    connected_network_id VARCHAR(128) NOT NULL,
    status ENUM('ACTIVE','DISABLED','TEMPORARY_BLOCKED'),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE heater (
    id INT NOT NULL AUTO_INCREMENT,
    batch_no VARCHAR(64) NOT NULL,
    manufactured_resistance FLOAT NOT NULL,
    current_resistance FLOAT NOT NULL,
    device_id INT NOT NULL,
    connected_status ENUM('CONNECTED','DISCONNECTED'),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (device_id) REFERENCES device(id)
);

CREATE TABLE user_treatment_session (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    device_id INT NOT NULL,
    protocol_id INT DEFAULT 0,
    selected_pain_level INT DEFAULT 0,
    selected_temperature INT DEFAULT 0,
    initial_selected_time INT DEFAULT 0,
    initial_battery_level INT DEFAULT 0,
    final_temperature INT DEFAULT 0,
    actual_treatment_time INT DEFAULT 0,
    end_battery_level INT DEFAULT 0,
    feedback_pain_level INT DEFAULT 0,
    status ENUM('STARTED','STOPPED','FINISHED'),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (device_id) REFERENCES device(id)
);

CREATE TABLE question (
    id INT NOT NULL AUTO_INCREMENT,
    form_field_type VARCHAR(64) NOT NULL,
    question VARCHAR(512) NOT NULL,
    enabled TINYINT(1) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE answer (
    id INT NOT NULL AUTO_INCREMENT,
    question_id INT NOT NULL,
    answer VARCHAR(512) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (question_id) REFERENCES question(id)
);

CREATE TABLE user_treatment_answering_session (
    id INT NOT NULL AUTO_INCREMENT,
    session_id INT NOT NULL,
    question_id INT NOT NULL,
    answer_id INT NULL,
    answer  VARCHAR(256) NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (session_id) REFERENCES user_treatment_session(id),
    FOREIGN KEY (question_id) REFERENCES question(id)
);


CREATE TABLE user_device_history (
    id INT NOT NULL AUTO_INCREMENT,
    device_id INT NOT NULL,
    user_id INT DEFAULT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    connected_time TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (device_id) REFERENCES device(id)
);

CREATE TABLE user_device (
    id INT NOT NULL AUTO_INCREMENT,
    device_id INT NOT NULL,
    user_id INT DEFAULT NULL,
    enabled TINYINT(1) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated_date TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (device_id) REFERENCES device(id)
);

