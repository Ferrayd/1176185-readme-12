CREATE DATABASE readme
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE readme;

CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  email VARCHAR(255) NOT NULL UNIQUE,
  login VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255),
  avatar VARCHAR(255)
);

CREATE TABLE content_type (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  icon_class VARCHAR(255) NOT NULL
);

CREATE TABLE hashtags (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE posts (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  quote_author TEXT,
  image VARCHAR(255),
  video VARCHAR(255),
  link TEXT,
  views INT UNSIGNED DEFAULT 0,
  author_id INT UNSIGNED,
  type_id INT UNSIGNED,
  hashtag_id INT UNSIGNED,

  FOREIGN KEY (author_id) REFERENCES users (id) on update cascade on delete set null,
  FOREIGN KEY (type_id) REFERENCES content_type (id) on update cascade on delete set null,
  UNIQUE KEY (id, hashtag_id)
);

CREATE TABLE comments (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  creation_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  content TEXT NOT NULL,
  author_id INT UNSIGNED,
  post_id INT UNSIGNED,

  FOREIGN KEY (author_id) REFERENCES users (id) on update cascade on delete set null,
  FOREIGN KEY (post_id) REFERENCES posts (id) on update cascade on delete set null
);

CREATE TABLE subscription (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  follower INT UNSIGNED,
  user_id INT UNSIGNED,

  FOREIGN KEY (follower) REFERENCES users (id) on update cascade on delete set null,
  FOREIGN KEY (user_id) REFERENCES users (id) on update cascade on delete set null,
  UNIQUE KEY (follower, user_id)
);

CREATE TABLE likes (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED,
  liked_post INT UNSIGNED,

  FOREIGN KEY (user_id) REFERENCES users (id) on update cascade on delete set null,
  FOREIGN KEY (liked_post) REFERENCES posts (id) on update cascade on delete set null,
  UNIQUE KEY (user_id, liked_post)
);


CREATE TABLE messages (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  message_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  content TEXT,
  sender INT UNSIGNED,
  recipient INT UNSIGNED,

  FOREIGN KEY (sender) REFERENCES users (id) on update cascade on delete set null,
  FOREIGN KEY (recipient) REFERENCES users (id) on update cascade on delete set null
);

CREATE TABLE posts_hashtags (
  post_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  hashtag_id INT UNSIGNED,

  FOREIGN KEY (post_id) REFERENCES posts (id) on update cascade on delete cascade,
  FOREIGN KEY (hashtag_id) REFERENCES hashtags (id) on update cascade on delete set null,
  UNIQUE KEY (post_id, hashtag_id)
);

CREATE TABLE dialog (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sender INT UNSIGNED NOT NULL,
  messages_id INT UNSIGNED NOT NULL,
  
  FOREIGN KEY (sender) REFERENCES users (id) on update cascade on delete cascade,
  FOREIGN KEY (messages_id) REFERENCES messages (id) on update cascade on delete cascade
);
