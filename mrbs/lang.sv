<?php
# $Id: lang.sv,v 1.1 2007/06/22 23:45:28 amagrace Exp $

# This file contains PHP code that specifies language specific strings
# The default strings come from lang.en, and anything in a locale
# specific file will overwrite the default. This is the Swedish file.
#
# Translated provede by: Bo Kleve (bok@unit.liu.se), MissterX
# Modified on 2006-01-04 by: Bj�rn Wiberg <Bjorn.Wiberg@its.uu.se>
#
#
# This file is PHP code. Treat it as such.

# The charset to use in "Content-type" header
$vocab["charset"]            = "iso-8859-1";

# Used in style.inc
$vocab["mrbs"]               = "MRBS - M�tesRumsBokningsSystem";

# Used in functions.inc
$vocab["report"]             = "Rapport";
$vocab["admin"]              = "Admin";
$vocab["help"]               = "Hj�lp";
$vocab["search"]             = "S�k:";
$vocab["not_php3"]           = "<H1>VARNING: Detta fungerar f�rmodligen inte med PHP3</H1>";

# Used in day.php
$vocab["bookingsfor"]        = "Bokningar f�r";
$vocab["bookingsforpost"]    = "";
$vocab["areas"]              = "Omr�den";
$vocab["daybefore"]          = "G� till f�reg�ende dag";
$vocab["dayafter"]           = "G� till n�sta dag";
$vocab["gototoday"]          = "G� till idag";
$vocab["goto"]               = "G� till";
$vocab["highlight_line"]     = "Markera denna rad";
$vocab["click_to_reserve"]   = "Klicka p� cellen f�r att g�ra en bokning.";

# Used in trailer.inc
$vocab["viewday"]            = "Visa dag";
$vocab["viewweek"]           = "Visa vecka";
$vocab["viewmonth"]          = "Visa m�nad";
$vocab["ppreview"]           = "F�rhandsgranska";

# Used in edit_entry.php
$vocab["addentry"]           = "Ny bokning";
$vocab["editentry"]          = "�ndra bokningen";
$vocab["editseries"]         = "�ndra serie";
$vocab["namebooker"]         = "Kort beskrivning:";
$vocab["fulldescription"]    = "Fullst�ndig beskrivning:";
$vocab["date"]               = "Datum:";
$vocab["start_date"]         = "Starttid:";
$vocab["end_date"]           = "Sluttid:";
$vocab["time"]               = "Tid:";
$vocab["period"]             = "Period:";
$vocab["duration"]           = "L�ngd:";
$vocab["seconds"]            = "sekunder";
$vocab["minutes"]            = "minuter";
$vocab["hours"]              = "timmar";
$vocab["days"]               = "dagar";
$vocab["weeks"]              = "veckor";
$vocab["years"]              = "�r";
$vocab["periods"]            = "perioder";
$vocab["all_day"]            = "hela dagen";
$vocab["type"]               = "Typ:";
$vocab["internal"]           = "Internt";
$vocab["external"]           = "Externt";
$vocab["save"]               = "Spara";
$vocab["rep_type"]           = "Repetitionstyp:";
$vocab["rep_type_0"]         = "ingen";
$vocab["rep_type_1"]         = "dagligen";
$vocab["rep_type_2"]         = "varje vecka";
$vocab["rep_type_3"]         = "m�natligen";
$vocab["rep_type_4"]         = "�rligen";
$vocab["rep_type_5"]         = "M�nadsvis, samma dag";
$vocab["rep_type_6"]         = "Veckovis";
$vocab["rep_end_date"]       = "Repetition slutdatum:";
$vocab["rep_rep_day"]        = "Repetitionsdag:";
$vocab["rep_for_weekly"]     = "(vid varje vecka)";
$vocab["rep_freq"]           = "Intervall:";
$vocab["rep_num_weeks"]      = "Antal veckor";
$vocab["rep_for_nweekly"]    = "(F�r x-veckor)";
$vocab["ctrl_click"]         = "H�ll ner tangenten <I>Ctrl</I> och klicka f�r att v�lja mer �n ett rum";
$vocab["entryid"]            = "Boknings-ID ";
$vocab["repeat_id"]          = "Repetions-ID "; 
$vocab["you_have_not_entered"] = "Du har inte angivit";
$vocab["you_have_not_selected"] = "Du har inte valt";
$vocab["valid_room"]         = "ett giltigt rum.";
$vocab["valid_time_of_day"]  = "en giltig tidpunkt p� dagen.";
$vocab["brief_description"]  = "en kort beskrivning.";
$vocab["useful_n-weekly_value"] = "ett anv�ndbart n-veckovist v�rde.";

# Used in view_entry.php
$vocab["description"]        = "Beskrivning:";
$vocab["room"]               = "Rum";
$vocab["createdby"]          = "Skapad av:";
$vocab["lastupdate"]         = "Senast uppdaterad:";
$vocab["deleteentry"]        = "Radera bokningen";
$vocab["deleteseries"]       = "Radera serie";
$vocab["confirmdel"]         = "�r du s�ker att\\ndu vill radera\\nden h�r bokningen?\\n\\n";
$vocab["returnprev"]         = "�ter till f�reg�ende sida";
$vocab["invalid_entry_id"]   = "Ogiltigt boknings-ID!";
$vocab["invalid_series_id"]  = "Ogiltigt serie-ID!";

# Used in edit_entry_handler.php
$vocab["error"]              = "Fel";
$vocab["sched_conflict"]     = "Bokningskonflikt";
$vocab["conflict"]           = "Den nya bokningen krockar med f�ljande bokning(ar):";
$vocab["too_may_entrys"]     = "De valda inst�llningarna skapar f�r m�nga bokningar.<BR>V.g. anv�nd andra inst�llningar!";
$vocab["returncal"]          = "�terg� till kalendervy";
$vocab["failed_to_acquire"]  = "Kunde ej f� exklusiv databas�tkomst"; 
$vocab["invalid_booking"]    = "Ogiltig bokning";
$vocab["must_set_description"] = "Du m�ste ange en kort beskrivning f�r bokningen. V�nligen g� tillbaka och korrigera detta.";
$vocab["mail_subject_entry"] = $mail["subject"];
$vocab["mail_body_new_entry"] = $mail["new_entry"];
$vocab["mail_body_del_entry"] = $mail["deleted_entry"];
$vocab["mail_body_changed_entry"] = $mail["changed_entry"];
$vocab["mail_subject_delete"] = $mail["subject_delete"];

# Authentication stuff
$vocab["accessdenied"]       = "�tkomst nekad";
$vocab["norights"]           = "Du har inte r�ttighet att �ndra bokningen.";
$vocab["please_login"]       = "V�nligen logga in";
$vocab["user_name"]          = "Anv�ndarnamn";
$vocab["user_password"]      = "L�senord";
$vocab["unknown_user"]       = "Ok�nd anv�ndare";
$vocab["you_are"]            = "Du �r";
$vocab["login"]              = "Logga in";
$vocab["logoff"]             = "Logga ut";

# Authentication database
$vocab["user_list"]          = "Anv�ndarlista";
$vocab["edit_user"]          = "Editera anv�ndare";
$vocab["delete_user"]        = "Radera denna anv�ndare";
#$vocab["user_name"]         = Use the same as above, for consistency.
#$vocab["user_password"]     = Use the same as above, for consistency.
$vocab["user_email"]         = "E-postadress";
$vocab["password_twice"]     = "Om du vill �ndra ditt l�senord, v�nligen mata in detta tv� g�nger";
$vocab["passwords_not_eq"]   = "Fel: L�senorden st�mmer inte �verens.";
$vocab["add_new_user"]       = "L�gg till anv�ndare";
$vocab["rights"]             = "R�ttigheter";
$vocab["action"]             = "Aktion";
$vocab["user"]               = "Anv�ndare";
$vocab["administrator"]      = "Administrat�r";
$vocab["unknown"]            = "Ok�nd";
$vocab["ok"]                 = "OK";
$vocab["show_my_entries"]    = "Klicka f�r att visa alla dina aktuella bokningar";
$vocab["no_users_initial"]   = "Inga anv�ndare finns i databasen. Till�ter initialt skapande av anv�ndare.";
$vocab["no_users_create_first_admin"] = "Skapa en administrativ anv�ndare f�rst. D�refter kan du logga in och skapa fler anv�ndare.";

# Used in search.php
$vocab["invalid_search"]     = "Tom eller ogiltig s�kstr�ng.";
$vocab["search_results"]     = "S�kresultat f�r:";
$vocab["nothing_found"]      = "Inga s�ktr�ffar hittades.";
$vocab["records"]            = "Bokning ";
$vocab["through"]            = " t.o.m. ";
$vocab["of"]                 = " av ";
$vocab["previous"]           = "F�reg�ende";
$vocab["next"]               = "N�sta";
$vocab["entry"]              = "Bokning";
$vocab["view"]               = "Visa";
$vocab["advanced_search"]    = "Avancerad s�kning";
$vocab["search_button"]      = "S�k";
$vocab["search_for"]         = "S�k f�r";
$vocab["from"]               = "Fr�n";

# Used in report.php
$vocab["report_on"]          = "Rapport �ver m�ten:";
$vocab["report_start"]       = "Startdatum f�r rapport:";
$vocab["report_end"]         = "Slutdatum f�r rapport:";
$vocab["match_area"]         = "S�k p� plats:";
$vocab["match_room"]         = "S�k p� rum:";
$vocab["match_type"]         = "S�k p� bokningstyp:";
$vocab["ctrl_click_type"]    = "H�ll ner tangenten <I>Ctrl</I> och klicka f�r att v�lja fler �n en typ";
$vocab["match_entry"]        = "S�k p� kort beskrivning:";
$vocab["match_descr"]        = "S�k p� fullst�ndig beskrivning:";
$vocab["include"]            = "Inkludera:";
$vocab["report_only"]        = "Endast rapport";
$vocab["summary_only"]       = "Endast sammanst�llning";
$vocab["report_and_summary"] = "Rapport och sammanst�llning";
$vocab["summarize_by"]       = "Sammanst�ll p�:";
$vocab["sum_by_descrip"]     = "Kort beskrivning";
$vocab["sum_by_creator"]     = "Skapare";
$vocab["entry_found"]        = "bokning hittad";
$vocab["entries_found"]      = "bokningar hittade";
$vocab["summary_header"]     = "Sammanst�llning �ver (bokningar) timmar";
$vocab["summary_header_per"] = "Sammanst�llning �ver (bokningar) perioder";
$vocab["total"]              = "Totalt";
$vocab["submitquery"]        = "Skapa rapport";
$vocab["sort_rep"]           = "Sortera rapport efter:";
$vocab["sort_rep_time"]      = "Startdatum/starttid";
$vocab["rep_dsp"]            = "Visa i rapport:";
$vocab["rep_dsp_dur"]        = "L�ngd";
$vocab["rep_dsp_end"]        = "Sluttid";

# Used in week.php
$vocab["weekbefore"]         = "F�reg�ende vecka";
$vocab["weekafter"]          = "N�sta vecka";
$vocab["gotothisweek"]       = "Denna vecka";

# Used in month.php
$vocab["monthbefore"]        = "F�reg�ende m�nad";
$vocab["monthafter"]         = "N�sta m�nad";
$vocab["gotothismonth"]      = "Denna m�nad";

# Used in {day week month}.php
$vocab["no_rooms_for_area"]  = "Rum saknas f�r denna plats";

# Used in admin.php
$vocab["edit"]               = "�ndra";
$vocab["delete"]             = "Radera";
$vocab["rooms"]              = "Rum";
$vocab["in"]                 = "i";
$vocab["noareas"]            = "Inget omr�de";
$vocab["addarea"]            = "L�gg till omr�de";
$vocab["name"]               = "Namn";
$vocab["noarea"]             = "Inget omr�de valt";
$vocab["browserlang"]        = "Din webbl�sare �r inst�lld att anv�nda spr�k(en)";
$vocab["postbrowserlang"]    = "";
$vocab["addroom"]            = "L�gg till rum";
$vocab["capacity"]           = "Kapacitet";
$vocab["norooms"]            = "Inga rum.";
$vocab["administration"]     = "Administration";

# Used in edit_area_room.php
$vocab["editarea"]           = "�ndra omr�de";
$vocab["change"]             = "�ndra";
$vocab["backadmin"]          = "Tillbaka till Administration";
$vocab["editroomarea"]       = "�ndra omr�de eller rum";
$vocab["editroom"]           = "�ndra rum";
$vocab["update_room_failed"] = "Uppdatering av rum misslyckades: ";
$vocab["error_room"]         = "Fel: rum ";
$vocab["not_found"]          = " hittades ej";
$vocab["update_area_failed"] = "Uppdatering av omr�de misslyckades: ";
$vocab["error_area"]         = "Fel: omr�de";
$vocab["room_admin_email"]   = "E-postadress till rumsansvarig:";
$vocab["area_admin_email"]   = "E-postadress till omr�desansvarig";
$vocab["invalid_email"]      = "Ogiltig e-postadress!";

# Used in del.php
$vocab["deletefollowing"]    = "Detta raderar f�ljande bokningar";
$vocab["sure"]               = "�r du s�ker?";
$vocab["YES"]                = "JA";
$vocab["NO"]                 = "NEJ";
$vocab["delarea"]            = "Du m�ste ta bort alla rum i detta omr�de innan du kan ta bort omr�det!<p>";
$vocab["backadmin"]          = "Tillbaka till Administration";

# Used in help.php
$vocab["about_mrbs"]         = "Om MRBS";
$vocab["database"]           = "Databas: ";
$vocab["system"]             = "System: ";
$vocab["please_contact"]     = "Var v�nlig kontakta ";
$vocab["for_any_questions"]  = "f�r eventuella fr�gor som ej besvaras h�r.";

# Used in mysql.inc AND pgsql.inc
$vocab["failed_connect_db"]  = "Fatalt fel: Kunde ej ansluta till databasen!";

?>
