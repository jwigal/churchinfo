<?php
# $Id: lang.el,v 1.1 2007/06/22 23:45:28 amagrace Exp $

# This file contains PHP code that specifies language specific strings
# The default strings come from lang.en, and anything in a locale
# specific file will overwrite the default. This is a Greek file.
#
#
#
#
# This file is PHP code. Treat it as such.

# The charset to use in "Content-type" header
$vocab["charset"]            = "iso-8859-7";

# Used in style.inc
$vocab["mrbs"]               = "������� ��������� �������� (MRBS)";

# Used in functions.inc
$vocab["report"]             = "�������";
$vocab["admin"]              = "����������";
$vocab["help"]               = "�������";
$vocab["search"]             = "���������:";
$vocab["not_php3"]           = "<H1>�������: ���� � ������ ��� �������� �� PHP3</H1>";

# Used in day.php
$vocab["bookingsfor"]        = "��������� ���";
$vocab["bookingsforpost"]    = ""; # Goes after the date
$vocab["areas"]              = "��������:";
$vocab["daybefore"]          = "�������� ���� ����������� ����";
$vocab["dayafter"]           = "�������� ���� ������� ����";
$vocab["gototoday"]          = "�������� ��� �������� ����";
$vocab["goto"]               = "��������";
$vocab["highlight_line"]     = "Highlight this line";
$vocab["click_to_reserve"]   = "Click on the cell to make a reservation.";

# Used in trailer.inc
$vocab["viewday"]            = "������� ��� �����";
$vocab["viewweek"]           = "������� ��� ��������";
$vocab["viewmonth"]          = "������� ��� ����";
$vocab["ppreview"]           = "������������� ���������";

# Used in edit_entry.php
$vocab["addentry"]           = "�������� ��������";
$vocab["editentry"]          = "����������� ��������";
$vocab["editseries"]         = "����������� ������";
$vocab["namebooker"]         = "������� ���������:";
$vocab["fulldescription"]    = "������ ���������:<br>&nbsp;&nbsp;(������� ������,<br>&nbsp;&nbsp;���������/��������� ���.)";
$vocab["date"]               = "����������:";
$vocab["start_date"]         = "��� �������:";
$vocab["end_date"]           = "��� �����:";
$vocab["time"]               = "���:";
$vocab["period"]             = "Period:";
$vocab["duration"]           = "��������:";
$vocab["seconds"]            = "������������";
$vocab["minutes"]            = "�����";
$vocab["hours"]              = "����";
$vocab["days"]               = "������";
$vocab["weeks"]              = "���������";
$vocab["years"]              = "������";
$vocab["periods"]            = "periods";
$vocab["all_day"]            = "�������� ����";
$vocab["type"]               = "�����:";
$vocab["internal"]           = "���������";
$vocab["external"]           = "���������";
$vocab["save"]               = "����������";
$vocab["rep_type"]           = "����� ����������:";
$vocab["rep_type_0"]         = "������";
$vocab["rep_type_1"]         = "��������";
$vocab["rep_type_2"]         = "�����������";
$vocab["rep_type_3"]         = "�������";
$vocab["rep_type_4"]         = "������";
$vocab["rep_type_5"]         = "�������, ���������� �����";
$vocab["rep_type_6"]         = "n-�����������";
$vocab["rep_end_date"]       = "���������� ����������� ����������:";
$vocab["rep_rep_day"]        = "����� ����������:";
$vocab["rep_for_weekly"]     = "(��� (n-)�����������)";
$vocab["rep_freq"]           = "���������:";
$vocab["rep_num_weeks"]      = "������� ���������";
$vocab["rep_for_nweekly"]    = "(��� n-�����������)";
$vocab["ctrl_click"]         = "�������������� Control-Click ��� �� ��������� ������������ ��� ��� ��������";
$vocab["entryid"]            = "�������������� ������� �������� ";
$vocab["repeat_id"]          = "�������������� ������� ���������� "; 
$vocab["you_have_not_entered"] = "��� �������� �� (��)";
$vocab["you_have_not_selected"] = "You have not selected a";
$vocab["valid_room"]         = "room.";
$vocab["valid_time_of_day"]  = "������ ���.";
$vocab["brief_description"]  = "������� ���������.";
$vocab["useful_n-weekly_value"] = "������� n-����������� ����.";

# Used in view_entry.php
$vocab["description"]        = "���������:";
$vocab["room"]               = "�������";
$vocab["createdby"]          = "������������� ���:";
$vocab["lastupdate"]         = "��������� ���������:";
$vocab["deleteentry"]        = "�������� ��������";
$vocab["deleteseries"]       = "�������� ������ ����������";
$vocab["confirmdel"]         = "����� �������\\n��� ������ ��\\n���������� ���� ��� �������;\\n\\n";
$vocab["returnprev"]         = "��������� ���� ����������� ������";
$vocab["invalid_entry_id"]   = "����� �������������� ������� �������.";
$vocab["invalid_series_id"]  = "Invalid series id.";

# Used in edit_entry_handler.php
$vocab["error"]              = "������";
$vocab["sched_conflict"]     = "�������������� ���������������";
$vocab["conflict"]           = "� ��� ������� ���������� �� ��� ��������� ��������:";
$vocab["too_may_entrys"]     = "�� �������� �� ������������� ���������� ������ ��������.<BR>�������� ��������������� ������������ ��������!";
$vocab["returncal"]          = "��������� �� ������� �����������";
$vocab["failed_to_acquire"]  = "�������� ����������� ������������� ��������� ���� ���� ���������"; 
$vocab["mail_subject_entry"] = $mail["subject"];
$vocab["mail_body_new_entry"] = $mail["new_entry"];
$vocab["mail_body_del_entry"] = $mail["deleted_entry"];
$vocab["mail_body_changed_entry"] = $mail["changed_entry"];
$vocab["mail_subject_delete"] = $mail["subject_delete"];

# Authentication stuff
$vocab["accessdenied"]       = "������������ � ��������";
$vocab["norights"]           = "��� ����� ���������� ��������� ��� �� ������������� ���� �� �����������.";
$vocab["please_login"]       = "�������� ������ �������� (log in)";
$vocab["user_name"]          = "����� ������";
$vocab["user_password"]      = "������� ���������";
$vocab["unknown_user"]       = "�������� �������";
$vocab["you_are"]            = "�����";
$vocab["login"]              = "�������� (Log in)";
$vocab["logoff"]             = "������ (Log Off)";

# Authentication database
$vocab["user_list"]          = "User list";
$vocab["edit_user"]          = "Edit user";
$vocab["delete_user"]        = "Delete this user";
#$vocab["user_name"]         = Use the same as above, for consistency.
#$vocab["user_password"]     = Use the same as above, for consistency.
$vocab["user_email"]         = "Email address";
$vocab["password_twice"]     = "If you wish to change the password, please type the new password twice";
$vocab["passwords_not_eq"]   = "Error: The passwords do not match.";
$vocab["add_new_user"]       = "Add a new user";
$vocab["rights"]             = "Rights";
$vocab["action"]             = "Action";
$vocab["user"]               = "User";
$vocab["administrator"]      = "Administrator";
$vocab["unknown"]            = "Unknown";
$vocab["ok"]                 = "OK";
$vocab["show_my_entries"]    = "Click to display all my upcoming entries";

# Used in search.php
$vocab["invalid_search"]     = "���� � ���������� ������� ����������.";
$vocab["search_results"]     = "������������ ���������� ���:";
$vocab["nothing_found"]      = "��� �������� �������� ��� �� ����������.";
$vocab["records"]            = "���������� ";
$vocab["through"]            = " ��� ";
$vocab["of"]                 = " ��� ";
$vocab["previous"]           = "�����������";
$vocab["next"]               = "�������";
$vocab["entry"]              = "������";
$vocab["view"]               = "�������";
$vocab["advanced_search"]    = "��������� ���������";
$vocab["search_button"]      = "���������";
$vocab["search_for"]         = "��������� ���";
$vocab["from"]               = "���";

# Used in report.php
$vocab["report_on"]          = "������� ��� �����������:";
$vocab["report_start"]       = "���������� ������� ��������:";
$vocab["report_end"]         = "���������� ����� ��������:";
$vocab["match_area"]         = "��������� ��������:";
$vocab["match_room"]         = "��������� ��������:";
$vocab["match_type"]         = "Match type:";
$vocab["ctrl_click_type"]    = "Use Control-Click to select more than one type";
$vocab["match_entry"]        = "��������� �������� ����������:";
$vocab["match_descr"]        = "��������� ���������� ����������:";
$vocab["include"]            = "�� ��������������:";
$vocab["report_only"]        = "������� ����";
$vocab["summary_only"]       = "�������� ����";
$vocab["report_and_summary"] = "������� ��� ��������";
$vocab["summarize_by"]       = "������ ����:";
$vocab["sum_by_descrip"]     = "������� ���������";
$vocab["sum_by_creator"]     = "����������";
$vocab["entry_found"]        = "���������� �������";
$vocab["entries_found"]      = "������������ ��������";
$vocab["summary_header"]     = "�������� ���� ��������";
$vocab["summary_header_per"] = "Summary of (Entries) Periods";
$vocab["total"]              = "������";
$vocab["submitquery"]        = "�������� ��������";
$vocab["sort_rep"]           = "Sort Report by:";
$vocab["sort_rep_time"]      = "Start Date/Time";
$vocab["rep_dsp"]            = "Display in report:";
$vocab["rep_dsp_dur"]        = "Duration";
$vocab["rep_dsp_end"]        = "End Time";

# Used in week.php
$vocab["weekbefore"]         = "�������� ���� ����������� ��������";
$vocab["weekafter"]          = "�������� ���� ������� ��������";
$vocab["gotothisweek"]       = "�������� ���� �������� ��������";

# Used in month.php
$vocab["monthbefore"]        = "�������� ���� ����������� ����";
$vocab["monthafter"]         = "�������� ���� ������� ����";
$vocab["gotothismonth"]      = "�������� ���� �������� ����";

# Used in {day week month}.php
$vocab["no_rooms_for_area"]  = "��� ����� ������� �������� ��� ���� ��� �������";

# Used in admin.php
$vocab["edit"]               = "�����������";
$vocab["delete"]             = "��������";
$vocab["rooms"]              = "��������";
$vocab["in"]                 = "���";
$vocab["noareas"]            = "����� �������";
$vocab["addarea"]            = "�������� ��������";
$vocab["name"]               = "�����";
$vocab["noarea"]             = "��� ���� ��������� �������";
$vocab["browserlang"]        = "� ������������� ��� ������������";
$vocab["postbrowserlang"]    = "������.";
$vocab["addroom"]            = "�������� ��������";
$vocab["capacity"]           = "������������";
$vocab["norooms"]            = "����� �������.";
$vocab["administration"]     = "����������";

# Used in edit_area_room.php
$vocab["editarea"]           = "����������� ��������";
$vocab["change"]             = "������";
$vocab["backadmin"]          = "��������� ���� ����������";
$vocab["editroomarea"]       = "����������� ���������� �������� � ��������";
$vocab["editroom"]           = "����������� ��������";
$vocab["update_room_failed"] = "� ��������� ��� �������� �������: ";
$vocab["error_room"]         = "������: � ������� ";
$vocab["not_found"]          = " ��� �������";
$vocab["update_area_failed"] = "� ��������� ��� ������� �������: ";
$vocab["error_area"]         = "������: � ������� ";
$vocab["room_admin_email"]   = "Room admin email:";
$vocab["area_admin_email"]   = "Area admin email:";
$vocab["invalid_email"]      = "Invalid email!";

# Used in del.php
$vocab["deletefollowing"]    = "� �������� ���� �� ��������� ��� ��������� ���������";
$vocab["sure"]               = "����� ��������;";
$vocab["YES"]                = "���";
$vocab["NO"]                 = "���";
$vocab["delarea"]            = "������ �� ���������� ���� ��� �������� �� ���� �� ������� ��� �� ��������� �� ��� ����������<p>";

# Used in help.php
$vocab["about_mrbs"]         = "������� �� �� MRBS";
$vocab["database"]           = "���� ���������: ";
$vocab["system"]             = "�������: ";
$vocab["please_contact"]     = "�������� ������������� �� ";
$vocab["for_any_questions"]  = "��� ���� ��������� ��� ���������� ���.";

# Used in mysql.inc AND pgsql.inc
$vocab["failed_connect_db"]  = "������� ������: �������� �������� ��� ���� ���������";

?>
