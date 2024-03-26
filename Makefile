MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := test
.DELETE_ON_ERROR:
.SUFFIXES:

command_tests := viewcal_test remind_test addappointments_test findappointment_test
commands_to_test = $(command_tests:_test=)
calfile := test/test_calendar.txt

test/output:
	mkdir -p $@

.PHONY: test
test: test_code $(command_tests)

.PHONY: test_code
test_code:
	@echo "Cheking code for style and lint ..."
	pycodestyle --max-line-length=100 --indent-size=2 $(commands_to_test)
	flake8 --max-line-length=100 --indent-size=2 $(commands_to_test)
	@echo "Test succeeded!"

.PHONY: findappointment_test findapp_test_ui findapp_test_text \
	findapp_addapp
findappointment_test: findapp_test_text

findapp_test_text: | test/output
	@echo "Testing findappointment in text mode ..."
	faketime '2023-12-31 8:00' ./findappointment --once --dev --text_mode --calendar $(calfile) \
		> test/output/findapp_output.txt
	diff -q test/expected/findapp_expected_output.txt test/output/findapp_output.txt
	@echo "Test of findappointment succeeded!"

# TODO: test the UI somehow, possibly using selenium. In the meantime use this recipe to
# pop up the UI and test it manually.
findapp_test_ui: | test/output
	./findappointment --dev --calendar $(calfile) --sleep 10

findapp_addapp:
	echo "$$(date +"%H:%M") Event"| ./addappointments --calendar $(calfile)

.PHONY: addappointments_test
addappointments_test: | test/output
	@echo "Testing addappointments ..."
	cp -f $(calfile) $|/
	echo "8:00 Event" | faketime '2024-08-01' ./addappointments --id 1711146094.6305861 \
		--calendar $|/test_calendar.txt
	echo "2024-08-02 10:00 Event" | ./addappointments --id 1711146094.6305862 \
		--calendar $|/test_calendar.txt
	echo "remind `getmins 1d` 2024-05-01 10:00 Event" | ./addappointments --id 1711146094.6305863 \
		--calendar $|/test_calendar.txt
	echo "weekly 3 2024-08-04 10:00 Event" | ./addappointments --id 1711146094.6305864 \
		--calendar $|/test_calendar.txt
	echo "weekly 3 remind 65 2024-08-05 11:00 Event" | ./addappointments --id 1711146094.6305865 \
		--calendar $|/test_calendar.txt
	echo "biweekly 3 remind 65 2024-08-06 11:00 Event" | ./addappointments --id 1711146094.6305866 \
		--calendar $|/test_calendar.txt
	echo "monthly 3 remind 65 2024-08-07 11:00 Event" | ./addappointments --id 1711146094.6305867 \
		--calendar $|/test_calendar.txt
	echo "yearly 3 remind 65 2024-08-08 11:00 Event" | ./addappointments --id 1711146094.6305868 \
		--calendar $|/test_calendar.txt
	echo "yearly 3 remind 65 2024-08-38 11:00 Event" | ./addappointments --id 1711146094.6305868 \
		--calendar $|/test_calendar.txt
	echo "yearly 3 remind 65 2024-08-08 11:99 Event" | ./addappointments --id 1711146094.6305868 \
		--calendar $|/test_calendar.txt
	echo "hogwash" | ./addappointments --id 1711146094.6305868 \
		--calendar $|/test_calendar.txt
	diff -q test/expected/addapointments_expected_calendar.txt test/output/test_calendar.txt
	@echo "Test of addappointments succeeded!"

.PHONY: remind_test
remind_test: | test/output
	@echo "Testing remind ..."
	faketime '2024-03-19 8:00' ./remind -t $(calfile) 1710614701.06092 \
		"2024-3-19 8:0 Event" > test/output/remind_output.txt
	diff -q test/expected/remind_expected_output.txt test/output/remind_output.txt
	@echo "Test of remind succeeded!"


# TODO: test the UI somehow, possibly using selenium. In the meantime use this recipe to
# pop up the UI and test it manually.
.PHONY: remind_ui_test
remind_ui_test: | test/output
	faketime '2024-03-19 8:00' ./remind $(calfile) 1710614701.06092 \
		"2024-3-19 8:0 Event"

.PHONY: viewcal_test
viewcal_test: | test/output
	@echo "Testing viewcal ..."
	faketime '2024-12-31' ./viewcal --calendar $(calfile) 2024-01-01 > $|/result.txt
	echo "---TC01 Completed---" >> $|/result.txt
	faketime '2024-12-31' ./viewcal --calendar $(calfile) today >> $|/result.txt
	echo "---TC02 Completed---" >> $|/result.txt
	faketime '2024-12-31' ./viewcal --calendar $(calfile) this today >> $|/result.txt
	echo "---TC03 Completed---" >> $|/result.txt
	faketime '2023-12-31' ./viewcal --calendar $(calfile) last today >> $|/result.txt
	echo "---TC04 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) last today >> $|/result.txt
	echo "---TC05 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) next today >> $|/result.txt
	echo "---TC06 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal --calendar $(calfile) yesterday >> $|/result.txt
	echo "---TC07 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal --calendar $(calfile) this yesterday >> $|/result.txt
	echo "---TC08 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal --calendar $(calfile) last yesterday >> $|/result.txt
	echo "---TC09 Completed---" >> $|/result.txt
	faketime '2024-01-02' ./viewcal --calendar $(calfile) next yesterday >> $|/result.txt
	echo "---TC10 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) tomorrow >> $|/result.txt
	echo "---TC11 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) this tomorrow >> $|/result.txt
	echo "---TC12 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) last tomorrow >> $|/result.txt
	echo "---TC13 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) next tomorrow >> $|/result.txt
	echo "---TC14 Completed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal --calendar $(calfile) week >> $|/result.txt
	echo "---TC15 Completed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal --calendar $(calfile) this week >> $|/result.txt
	echo "---TC16 Completed---" >> $|/result.txt
	faketime '2024-01-28' ./viewcal --calendar $(calfile) next week >> $|/result.txt
	echo "---TC17 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) last week >> $|/result.txt
	echo "---TC18 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) month >> $|/result.txt
	echo "---TC19 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) this month >> $|/result.txt
	echo "---TC20 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) next month >> $|/result.txt
	echo "---TC21 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) last month >> $|/result.txt
	echo "---TC22 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) year >> $|/result.txt
	echo "---TC23 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) this year >> $|/result.txt
	echo "---TC24 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) next year >> $|/result.txt
	echo "---TC25 Completed---" >> $|/result.txt
	faketime '2024-01-10' ./viewcal --calendar $(calfile) last year >> $|/result.txt
	echo "---TC26 Completed---" >> $|/result.txt
	faketime '2024-05-31' ./viewcal --calendar $(calfile) -a week >> $|/result.txt
	echo "---TC27 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal --calendar $(calfile) -a month >> $|/result.txt
	echo "---TC28 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal --calendar $(calfile) -a year >> $|/result.txt
	echo "---TC29 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal --calendar $(calfile) -a next year >> $|/result.txt
	echo "---TC30 Completed---" >> $|/result.txt
	faketime '2024-06-01' ./viewcal --calendar $(calfile) -a -r year >> $|/result.txt
	echo "---TC31 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) monday >> $|/result.txt
	echo "---TC32 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) tuesday >> $|/result.txt
	echo "---TC33 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) wednesday >> $|/result.txt
	echo "---TC34 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) thursday >> $|/result.txt
	echo "---TC35 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) friday >> $|/result.txt
	echo "---TC36 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) saturday >> $|/result.txt
	echo "---TC37 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) sunday >> $|/result.txt
	echo "---TC38 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) next tuesday >> $|/result.txt
	echo "---TC39 Completed---" >> $|/result.txt
	faketime '2024-03-04' ./viewcal --calendar $(calfile) last thursday >> $|/result.txt
	echo "---TC40 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal --calendar $(calfile) march >> $|/result.txt
	echo "---TC41 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal --calendar $(calfile) january >> $|/result.txt
	echo "---TC42 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal --calendar $(calfile) february >> $|/result.txt
	echo "---TC43 Completed---" >> $|/result.txt
	faketime '2024-03-18' ./viewcal --calendar $(calfile) next january >> $|/result.txt
	echo "---TC44 Completed---" >> $|/result.txt
	faketime '2024-12-01' ./viewcal --calendar $(calfile) last december >> $|/result.txt
	echo "---TC45 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) 2024-02 >> $|/result.txt
	echo "---TC46 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) 2024 >> $|/result.txt
	echo "---TC47 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) 2025 >> $|/result.txt
	echo "---TC48 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) 2023 >> $|/result.txt
	echo "---TC49 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal --calendar $(calfile) 2023-12 >> $|/result.txt
	echo "---TC50 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -v --calendar $(calfile) today >> $|/result.txt
	echo "---TC51 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -v --calendar $(calfile) this week >> $|/result.txt
	echo "---TC52 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -v --calendar $(calfile) this month >> $|/result.txt
	echo "---TC53 Completed---" >> $|/result.txt
	faketime '2024-01-01' ./viewcal -v --calendar $(calfile) this year >> $|/result.txt
	echo "---TC54 Completed---" >> $|/result.txt
	diff -q test/expected/viewcal_expected.txt $|/result.txt
	@echo "Test of viewcal succeeded!"

clean:
	rm -Rf test/output
