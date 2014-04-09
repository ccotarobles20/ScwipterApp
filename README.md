Scwipter
========

A screenwriting app!  Front-End is nearly in place at this point, just a few kinks to work out and then onto back-end.

What I have so far:

UITableView allows you to create multiple screenplays.  A linked-list of custom-built UITextViews stores the contents of each screenplay the user works on.  At any point in time, currentTextBox stores the selected TextView (which is highlighted in blue for convenience of the user).  Swipe right to change the type of text box (Character vs Action vs Dialogue etc).  Swipe left to delete the text box and remove it from the linked-list.

Currently supports the following types of Text Boxes:

ACT HEADING
SCENE HEADING
DIALOGUE
CHARACTER
ACTION
PARENTHETICAL

Goals for the Front-End still:

1. Cleaning up the view so that everything looks clean when the device is rotated or when on an iPad.
2. The pointer to the head of the linked list should point to the title at the top.
3. Other miscellaneous things that would be nice to do after I complete the back-end.

Goals for the Back-End:

1. Core-data storage for the screenplays so they don't get deleted all the time.
2. Read in fountain text files and also write out to fountain text files.  Fountain Text Info Here: http://fountain.io/
3. Write-out to final-draft files and also read-in final draft files though the latter may be the hardest.
