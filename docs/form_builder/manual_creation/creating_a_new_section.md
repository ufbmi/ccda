## Creating a New Section

1. Open a new insert form on the 'sections' table
2. Get the auto-incremented ID that is given when the entry into 'sections' is created
3. Get the 'id' from the 'lu_languages' table for the language form you are adding
4. Open a new insert form on the 'preferences_text' table
	* Insert the following information:
		* languages_id = ID from #3
		* title = For a section, this is the text displayed in the panel-header of the bootstrap panel for the form
		* description = For a section, this is the text displayed under the header, instructing the user what they are doing
		* instructions = If the section will have further instructions on what the user is doing
		* placeholder = For a section, this is the text on the Next button
		* default = For a section, this is the text on the Previous button
		* sections_id = This is the ID from #2
5. Get the 'id' from the 'lu_types' table for the section type you are adding
6. Open a new insert form on the 'preferences_types' table
	* Insert the following information:
		* lu_types_id = This is the ID from #4
		* sections_id = This is the ID from #2
7. Open an edit form on the 'sections' table, for the form ID from #2

	* All of these fields need to be edited if the form is to show on the application
		* Set the forms_id for this form, if you have it
		* Set the next_sections_id to the ID for the next section if you have it. Leave NULL if this form is the final section
		* Set the previous_sections_id to the ID for the previous section if you have it. Leave NULL if this form is the first section
		* Set the sort_order for the section you just created. Set to 0 if this is the first section
		
	* There are two section options that are optional. isDisabled and isOpen.  These define whether the section's accordion is open (isOpen) and whether it is able to be controlled (isDisabled).  To set these for an individual section, you must insert a 2 new entries into the 'preferences_options' table.
		* To enable or disable isOpen, insert a new row with lu_options_id = 4, set the value to true for open, false for closed
		* To enable or disable isDisabled, insert a new row with lu_options_id = 5, set the value to true for disabled, false for enabled