CREATE TABLE q5(
        question_id INT,
        got_right INT,
        got_wrong INT,
        not_answer INT
);

DROP VIEW IF EXISTS tf_question_right CASCADE;
DROP VIEW IF EXISTS tf_question_wrong CASCADE;
DROP VIEW IF EXISTS tf_question_not_ans CASCADE;
DROP VIEW IF EXISTS mc_question_right CASCADE;
DROP VIEW IF EXISTS mc_question_wrong CASCADE;
DROP VIEW IF EXISTS mc_question_not_ans CASCADE;
DROP VIEW IF EXISTS nm_question_right CASCADE;
DROP VIEW IF EXISTS nm_question_wrong CASCADE;
DROP VIEW IF EXISTS nm_question_not_ans CASCADE;

-- Count the number of students who have the corret answers
-- for the true-false questions
CREATE VIEW tf_question_right AS 
	SELECT tf.id, count(student_id) as got_right
	FROM response_to_tf res, true_false tf, quiz_questions qq
	WHERE res.question_id = tf.id and student_answer = tf.correct_answer and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY tf.id;

-- Count the number of students who have the wrong answers 
-- for the true-false questions
CREATE VIEW tf_question_wrong AS 
	SELECT tf.id, count(student_id) as got_wrong
	FROM response_to_tf res, true_false tf, quiz_questions qq
	WHERE res.question_id = tf.id and student_answer != tf.correct_answer and student_answer is not null and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY tf.id;

-- Count the number of students who did not answer 
-- for the true-false questions
CREATE VIEW tf_question_not_ans AS 
	SELECT tf.id, count(student_id) as not_answer
	FROM response_to_tf res, true_false tf, quiz_questions qq
	WHERE res.question_id = tf.id and student_answer is null and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY tf.id;

-- Insert all the situation of true-false questions
insert into q5
	SELECT tf_question_right.id, got_right, got_wrong, not_answer
	FROM tf_question_right, tf_question_wrong, tf_question_not_ans
	WHERE tf_question_right.id = tf_question_wrong.id and tf_question_right.id = tf_question_not_ans.id;

-- Count the number of students who have the corret answers 
-- for the multiple choice questions
CREATE VIEW mc_question_right AS 
	SELECT mc.id, count(student_id) as got_right
	FROM response_to_mc res, multiple_choice mc, quiz_questions qq
	WHERE res.question_id = mc.id and student_answer = mc.correct_answer and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY mc.id;

-- Count the number of students who have the wrong answers 
-- for the multiple choice questions
CREATE VIEW mc_question_wrong AS 
	SELECT mc.id, count(student_id) as got_wrong
	FROM response_to_mc res, multiple_choice mc, quiz_questions qq
	WHERE res.question_id = mc.id and student_answer != mc.correct_answer and student_answer is not null and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY mc.id;

-- Count the number of students who did not answer 
-- for the multiple choice questions
CREATE VIEW mc_question_not_ans AS 
	SELECT mc.id, count(student_id) as not_answer
	FROM response_to_mc res, multiple_choice mc, quiz_questions qq
	WHERE res.question_id = mc.id and student_answer is null and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY mc.id;

-- Insert all the situation of multiple choice questions
insert into q5
	SELECT mc_question_right.id, got_right, got_wrong, not_answer
	FROM mc_question_right, mc_question_wrong, mc_question_not_ans
	WHERE mc_question_right.id = mc_question_wrong.id and mc_question_right.id = mc_question_not_ans.id;

-- Count the number of students who have the corret answers 
-- for the numeric questions
CREATE VIEW nm_question_right AS 
	SELECT nm.id, count(student_id) as got_right
	FROM response_to_nm res, numeric_question nm, quiz_questions qq
	WHERE res.question_id = nm.id and student_answer = nm.correct_answer and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY nm.id;

-- Count the number of students who have the wrong answers 
-- for the numeric questions
CREATE VIEW nm_question_wrong AS 
	SELECT nm.id, count(student_id) as got_wrong
	FROM response_to_nm res, numeric_question nm, quiz_questions qq
	WHERE res.question_id = nm.id and student_answer != nm.correct_answer and student_answer is not null and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY nm.id;

-- Count the number of students who did not answer 
-- for the numeric questions
CREATE VIEW nm_question_not_ans AS 
	SELECT nm.id, count(student_id) as not_answer
	FROM response_to_nm res, numeric_question nm, quiz_questions qq
	WHERE res.question_id = nm.id and student_answer is null and res.quiz_id = qq.quiz_id and qq.quiz_id = 'Pr1-220310'
	and qq.question_id = res.question_id
	GROUP BY nm.id;

-- Insert all the situation of numeric questions
insert into q5
	SELECT nm_question_right.id, got_right, got_wrong, not_answer
	FROM nm_question_right, nm_question_wrong, nm_question_not_ans
	WHERE nm_question_right.id = nm_question_wrong.id and nm_question_right.id = nm_question_not_ans.id;
