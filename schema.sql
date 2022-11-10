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
  content_class VARCHAR(255) NOT NULL
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

INSERT INTO content_type (title, content_class)
VALUES
('Цитата', 'post-quote'),
('Текст', 'post-text'),
('Фото', 'post-photo'),
('Ссылка', 'post-link');

/*добавляет пользователей*/
INSERT INTO users (reg_date, email, login, password, avatar)
VALUES
('2022.01.02 23:24:21', 'vl@mail.ru', 'Влад', 'vlad', 'userpic1.jpg'),
('2022.06.22 15:24:25', 'igor@yandex.ru', 'Игорь', 'igor', 'userpic2.jpg'),
('2022.08.13 12:02:43', 'artem@yandex.ru', 'Артем', 'artem', 'userpic3.jpg'),
('2022.08.13 12:02:43', 'lar@yandex.ru', 'Лариса', 'lar', 'userpic-larisa-small.jpg'),
('2022.08.13 12:02:43', 'aiv@yandex.ru', 'Иван', 'ivan', 'userpic4.jpg');

/*добавляет существующий список постов*/
INSERT INTO posts (title, content, views, author_id, type_id)
VALUES
('Цитата', 'Мы в жизни любим только раз, а после ищем лишь похожих', 100, 1, 1),
('Игра престолов', 'Не могу дождаться начала финального сезона своего любимого сериала!', 5000, 2, 2),
('Наконец, обработал фотки!', 'rock-medium.jpg', 150, 3, 3),
('Моя мечта', 'coast-medium.jpg', 10000, 1, 3);

/*комментарии к разным постам*/
INSERT INTO comments (creation_date, content, author_id, post_id)
VALUES
('2022.01.02 21:17:21', 'Прекрасная обработка! Так держать!', 1, 3),
('2022.02.02 11:00:00', 'Просто берет за душу!', 2, 1),
('2022.03.08 12:01:23', 'Лучше курсов не стречал!', 3, 2);

/*получает список постов с сортировкой по популярности и вместе с именами авторов и типом контента;*/
SELECT p.*, ct.title, u.login, u.avatar
FROM posts AS p
JOIN content_type ct ON p.type_id = ct.id
JOIN users u ON p.author_id = u.id
ORDER BY p.views DESC;

/*получает список постов для конкретного пользователя*/
SELECT p.title, p.content, u.login, p.views
FROM posts AS p
LEFT JOIN users AS u ON p.author_id=u.id
WHERE u.id=1;

/*получает список комментариев для одного поста, в комментариях должен быть логин пользователя*/
SELECT c.creation_date, c.content, u.login
FROM comments AS c
LEFT JOIN users AS u ON c.id=u.id
WHERE c.post_id=1;

/*добавляет лайк посту*/
INSERT INTO likes (user_id, liked_post) VALUES (2, 4);

/*подписаться на пользователя*/
INSERT INTO subscription (follower, user_id) VALUES (3, 1);