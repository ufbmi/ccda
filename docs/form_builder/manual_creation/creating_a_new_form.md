## Creating a New Form

1. Open a new insert form on the 'forms' table
2. Get the auto-incremented ID that is given when the entry into 'forms' is created
3. Get the 'id' from the 'lu_languages' table for the language form you are adding
4. Open a new insert form on the 'preferences_text' table
	* Insert the following information:
		* languages_id = ID from #3
		* title = For a form, this is the text displayed in the panel-header of the bootstrap panel for the form
		* description = For a form, this is the text displayed under the header, instructing the user what they are doing
		* instructions = If the form will have further instructions on what the user is doing
		* placeholder = For a form, this is the text on the Begin button
		* default = For a form, this is the text on the Finished button
		* forms_id = This is the ID from #2
5. Get the 'id' from the 'lu_types' table for the form type you are adding
6. Open a new insert form on the 'preferences_types' table
	* Insert the following information:
		* lu_types_id = This is the ID from #4
		* forms_id = This is the ID from #2
7. Open an edit form on the 'forms' table, for the form ID from #2

	* All of these fields need to be edited if the form is to show on the application
		* Set the projects_id for this form, if you have it
		* Set the next_forms_id to the ID for the next form if you have it. Leave NULL if this form is the final form
		* Set the previous_forms_id to the ID for the previous form if you have it. Leave NULL if this form is the first form
		* Set the sort_order for the form you just created. Set to 0 if this is the first form