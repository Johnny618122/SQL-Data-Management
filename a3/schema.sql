DROP SCHEMA IF EXISTS quizschema CASCADE;
CREATE SCHEMA quizschema;
SET SEARCH_PATH to quizschema;

CREATE TABLE student(
  id VARCHAR(10) primary key,
  -- The id of the student.
  first_name VARCHAR(50) NOT NULL,
  -- The first name of the student.
  last_name VARCHAR(50) NOT NULL
  -- The last name of the student.
);

CREATE TABLE class(
  id TEXT primary key,
  -- The id of the class.
  room VARCHAR(50) NOT NULL,
  -- The room of the class.
  grade VARCHAR(50) NOT NULL,
  -- The grade of class.
  teacher VARCHAR(50) NOT NULL,
  -- The teacher of the class.
  UNIQUE(room, teacher)
);

CREATE TABLE take(
  student_id VARCHAR(10) REFERENCES student(id),
  -- The id of the student.
  class_id TEXT REFERENCES class(id),
  -- The id of the class.
  PRIMARY KEY (student_id, class_id)
);

CREATE TABLE question_bank(
  id INT primary key,
  -- The id of the question.
  question_text TEXT NOT NULL
  -- The text of the question.
);

CREATE TABLE true_false(
  id INT primary key REFERENCES question_bank(id),
  -- The id of the question.
  correct_answer BOOLEAN NOT NULL
  -- The answer of the question.
);

CREATE TABLE multiple_choice(
  id INT primary key REFERENCES question_bank(id),
  -- The id of the question.
  correct_answer TEXT NOT NULL
  -- The answer of the question.
);

CREATE TABLE numeric_question(
  id INT primary key REFERENCES question_bank(id),
  -- The id of the question.
  correct_answer INT NOT NULL
  -- The answer of the question.
);

-- All the false options for multiple choice question.
CREATE TABLE options(
  question_id INT REFERENCES multiple_choice(id),
  -- The id of the MC question.
  option TEXT NOT NULL,
  -- The option of the MC question.
  hint TEXT,
  -- The hint of the MC question.
  primary key(question_id, option)
);

CREATE TABLE numeric_range(
  question_id INT REFERENCES numeric_question(id),
  -- The id of the MC question.
  lower_bound INT NOT NULL,
  -- The lower bound of the numeric question.
  upper_bound INT NOT NULL,
  -- The upper bound of the numeric question.
  hint TEXT NOT NULL,
  -- The hint of the numeric question.
  primary key(question_id, lower_bound, upper_bound)
);

-- A quiz is assigned with a class, which we store a class_id referencing id in the 'class' TABLE
-- We store the unique id as the key, title, due date and time by due_date and due_time, and flag 
-- which is a boolean variable, deciding the quiz has hint or not.
CREATE TABLE quiz(
  id TEXT primary key,
  -- The id of the quiz.
  title TEXT NOT NULL,
  -- The title of the quiz.
  due_date DATE NOT NULL,
  -- The due date of the quiz.
  due_time TIME NOT NULL,
  -- The due time of the quiz.
  class_id TEXT REFERENCES class(id) NOT NULL,
  -- The class id of the quiz.
  flag BOOLEAN NOT NULL
  -- Wether or not showing the hint.
);

-- Each questions in the question bank should be assigned into one quiz, so we store question_id and quiz_id 
-- to make question connecting to a quiz, and record weight of the question in that quiz. In order to achieve 
-- the same question in different quizzes, we make (quiz_id, question_id) as primary key.
CREATE TABLE quiz_questions(
  quiz_id TEXT REFERENCES quiz(id),
  -- The id of the quiz.
  question_id INT REFERENCES question_bank(id),
  -- The id of the question.
  weight INT NOT NULL,
  -- The weight of this question on this quiz.
  PRIMARY KEY(quiz_id, question_id)
);

-- In order to record students' responses to the quiz, we create three tables to record students' response 
-- to each three types questions. This table records the response to the true-false questions. We store 
-- the student id, quiz id, question id and the answer, whose type is BOOLEAN, because the answer of a 
-- true-false question is True or False. Student's answer could be NULL, because student may not answer 
-- all the questions.
CREATE TABLE response_to_tf(
  student_id VARCHAR(10) REFERENCES student(id),
  -- The id of the student.
  quiz_id TEXT REFERENCES quiz(id),
  -- The id of the quiz.
  question_id INT REFERENCES true_false(id),
  -- The id of the question.
  student_answer BOOLEAN,
  -- The student answer to the question.
  primary key(student_id, quiz_id, question_id)
);

-- Similiar to the TABLE response_to_tf, this table records the response to the multiple choice questions. 
-- We store the student id, quiz id, question id and the answer, whose type is TEXT. Student's answer could 
-- be NULL, because student may not answer all the questions.
CREATE TABLE response_to_mc(
  student_id VARCHAR(10) REFERENCES student(id),
  -- The id of the student.
  quiz_id TEXT REFERENCES quiz(id),
  -- The id of the quiz.
  question_id INT REFERENCES multiple_choice(id),
  -- The id of the question.
  student_answer TEXT,
  -- The student answer to the question.
  primary key(student_id, quiz_id, question_id)
);

-- Similiar to the TABLE response_to_mc, this table records the response to the numeric questions. 
-- We store the student id, quiz id, question id and the answer, whose type is INT, because integer is the 
-- only type of the answer of numeric question. Student's answer could be NULL, because student may not 
-- answer all the questions.
CREATE TABLE response_to_nm(
  student_id VARCHAR(10) REFERENCES student(id),
  -- The id of the student.
  quiz_id TEXT REFERENCES quiz(id),
  -- The id of the quiz.
  question_id INT REFERENCES numeric_question(id),
  -- The id of the question.
  student_answer INT,
  -- The student answer to the question.
  primary key(student_id, quiz_id, question_id)
);