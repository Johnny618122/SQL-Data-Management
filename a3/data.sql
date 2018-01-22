INSERT into question_bank values (782, 'What do you promise when you take the oath of citizenship?');
INSERT into multiple_choice values (782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II');
INSERT into options values (782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II', null), 
(782, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian', 'Think regally.'), 
(782, 'To pledge your loyalty to Canada from sea to sea', null);

INSERT into question_bank values (566, 'The Prime Minister, Justin Trudeau, is Canada''s Head of State.');
INSERT into true_false values (566, false);
INSERT into question_bank values (601, 'During the "Quiet Revolution", Quebec experienced rapid change. In what decade did this occur? (Enter the year that began the decade, e.g., 1840.)');

INSERT into numeric_question values (601, 1960);
INSERT into numeric_range values (601, 1800, 1900, 'The Quiet Revolution happened during the 20th Century.');
INSERT into numeric_range values (601, 2000, 2010, 'The Quiet Revolution happened some time ago.');
INSERT into numeric_range values (601, 2020, 3000, 'The Quiet Revolution has already happened!');

insert into question_bank values (625, 'What is the Underground Railroad?');
insert into multiple_choice values (625, 'A network used by slaves who escaped the United States into Canada');
insert into options values (625,'The first railway to cross Canada', 'The Underground Railroad was generally south to north, not east-west.'), 
	(625, 'The CPR''s secret railway line', 'The Underground Railroad was secret, but it had nothing to do with trains.'), 
	(625, 'The TTC subway system', 'The TTC is relatively recent; the Underground Railroad was in operation over 100 years ago.');
insert into question_bank values (790, 'During the War of 1812 the Americans burned down the Parliament Buildings in York (now Toronto). What did the British and Canadians do in return?');
insert into multiple_choice values (790, 'They burned down the White House in Washington D.C.');
insert into options values (790, 'They attacked American merchant ships'), 
	(790, 'They expanded their defence system, including Fort York'),
	(790, 'They captured Niagara Falls');


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
insert into class values ('g8r120MH', 'room 120', 'grade 8', 'Mr Higgins');

insert into quiz values ('Pr1-220310', 'Citizenship Test Practise Questions', '2017-10-01', '13:30', 'g8r120MH', true);
insert into quiz_questions values ('Pr1-220310', 601, 2);
insert into quiz_questions values ('Pr1-220310', 566, 1);
insert into quiz_questions values ('Pr1-220310', 790, 3);
insert into quiz_questions values ('Pr1-220310', 625, 2);

insert into student values ('0998801234', 'Lena', 'Headey'), ('0010784522', 'Peter', 'Dinklage'), ('0997733991', 'Emilia', 'Clarke'), ('5555555555', 'Kit', 'Harrington'), ('1111111111', 'Sophie', 'Turner');
insert into take values ('0998801234', 'g8r120MH'), ('0010784522', 'g8r120MH'), ('0997733991', 'g8r120MH'), ('5555555555', 'g8r120MH'), ('1111111111', 'g8r120MH');

insert into response_to_nm values ('0998801234', 'Pr1-220310', 601, 1950);
insert into response_to_tf values ('0998801234', 'Pr1-220310', 566, false);
insert into response_to_mc values ('0998801234', 'Pr1-220310', 790, 'They expanded their defence system, including Fort York');
insert into response_to_mc values ('0998801234', 'Pr1-220310', 625, 'A network used by slaves who escaped the United States into Canada');

insert into response_to_nm values ('0010784522', 'Pr1-220310', 601, 1960);
insert into response_to_tf values ('0010784522', 'Pr1-220310', 566, false);
insert into response_to_mc values ('0010784522', 'Pr1-220310', 790, 'They burned down the White House in Washington D.C.');
insert into response_to_mc values ('0010784522', 'Pr1-220310', 625, 'A network used by slaves who escaped the United States into Canada');

insert into response_to_nm values ('0997733991', 'Pr1-220310', 601, 1960);
insert into response_to_tf values ('0997733991', 'Pr1-220310', 566, true);
insert into response_to_mc values ('0997733991', 'Pr1-220310', 790, 'They burned down the White House in Washington D.C.');
insert into response_to_mc values ('0997733991', 'Pr1-220310', 625, 'The CPR''s secret railway line');

insert into response_to_nm values ('5555555555', 'Pr1-220310', 601, null);
insert into response_to_tf values ('5555555555', 'Pr1-220310', 566, false);
insert into response_to_mc values ('5555555555', 'Pr1-220310', 790, 'They captured Niagara Falls');
insert into response_to_mc values ('5555555555', 'Pr1-220310', 625, null);

insert into response_to_nm values ('1111111111', 'Pr1-220310', 601, null);
insert into response_to_tf values ('1111111111', 'Pr1-220310', 566, null);
insert into response_to_mc values ('1111111111', 'Pr1-220310', 790, null);
insert into response_to_mc values ('1111111111', 'Pr1-220310', 625, null);

insert into class values ('g5r366MN', 'room 366', 'grade 5', 'Miss Nyers');
insert into student values ('2222222222', 'Maisie', 'Williams');
insert into take values ('2222222222', 'g5r366MN');