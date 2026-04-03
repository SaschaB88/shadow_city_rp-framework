CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    license VARCHAR(64) NOT NULL,
    discord_id VARCHAR(64) NULL,
    fivem_id VARCHAR(64) NULL,
    last_known_name VARCHAR(128) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_seen_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_users_license (license)
);

CREATE TABLE IF NOT EXISTS characters (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    birth_date DATE NULL,
    gender VARCHAR(16) NULL,
    cash INT NOT NULL DEFAULT 500,
    bank INT NOT NULL DEFAULT 5000,
    job_name VARCHAR(64) NOT NULL DEFAULT 'unemployed',
    job_grade INT NOT NULL DEFAULT 0,
    pos_x DOUBLE NOT NULL DEFAULT 0,
    pos_y DOUBLE NOT NULL DEFAULT 0,
    pos_z DOUBLE NOT NULL DEFAULT 0,
    pos_h DOUBLE NOT NULL DEFAULT 0,
    metadata LONGTEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_characters_user_id (user_id),
    CONSTRAINT fk_characters_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_permissions (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    permission VARCHAR(64) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_user_permission (user_id, permission),
    CONSTRAINT fk_permissions_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);