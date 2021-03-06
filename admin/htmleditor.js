	var myeditor = new Object();
	var mytoolbar2 = new Object();
	var mytoolbar = new Object();
	
	function initPage()
	{
	myeditor = htmleditNew("myeditor", "default", document.getElementById("cellEdit"));
	mytoolbar = toolbarNew("mytoolbar", "default", document.getElementById("cellTB"));
	mytoolbar2 = toolbarNew("mytoolbar2", "default", document.getElementById("cellTB2"));
	mytoolbar.itemClick = doCmds;
	mytoolbar2.itemClick = doCmds;
	mytoolbar.createButton("style_Bold", "Bold", "editorImages/cmdB.gif");
	mytoolbar.createButton("style_Italic", "Italic", "editorImages/cmdI.gif");
	mytoolbar.createButton("style_Underline", "Underline", "editorImages/cmdU.gif");
	mytoolbar.createButton("style_Strikethrough", "Strikethrough", "editorImages/cmdStrike.gif");
	mytoolbar.createSeperator();
	mytoolbar.createButton("style_Superscript", "Superscript", "editorImages/cmdSuper.gif");
	mytoolbar.createButton("style_Subscript", "Subscript", "editorImages/cmdSub.gif");
	mytoolbar.createSeperator();
	mytoolbar.createButton("style_Justifyleft", "Align Left", "editorImages/cmdLeft.gif");
	mytoolbar.createButton("style_JustifyCenter", "Align Center", "editorImages/cmdCenter.gif");
	mytoolbar.createButton("style_JustifyRight", "Align Right", "editorImages/cmdRight.gif");
	mytoolbar.createSeperator();
	mytoolbar.createButton("style_Outdent", "Decrease Indent", "editorImages/cmdOutdent.gif");
	mytoolbar.createButton("style_Indent", "Incrase Indent", "editorImages/cmdIndent.gif");
	mytoolbar.createButton("style_Insertunorderedlist", "Bullet List", "editorImages/cmdBulleted.gif");
	mytoolbar.createButton("style_Insertorderedlist", "Numbered List", "editorImages/cmdNumbered.gif");
	mytoolbar.createSeperator();
	mytoolbar.createButton("insert_Link", "Insert Link", "editorImages/cmdLink.gif");
	mytoolbar.createButton("insert_Image", "Insert Image", "editorImages/cmdImage.gif");
	mytoolbar.createSeperator();
	mytoolbar.createButton("toggle_Mode", "Toggle Mode", "editorImages/cmdToggle.gif");
	
	var listArray = new Array();
	listArray[0] = mytoolbar2.createListItem("Arial", "Arial", "Arial");
	listArray[1] = mytoolbar2.createListItem("Comic Sans MS", "Comic Sans MS", "Comic Sans MS");
	listArray[2] = mytoolbar2.createListItem("Courier New", "Courier New", "Courier New");
	listArray[3] = mytoolbar2.createListItem("Georgia", "Georgia", "Georgia");
	listArray[4] = mytoolbar2.createListItem("Impact", "Impact", "Impact");
	listArray[5] = mytoolbar2.createListItem("Times New Roman", "Times New Roman", "Times New Roman");
	listArray[6] = mytoolbar2.createListItem("Trebuchet MS", "Trebuchet MS", "Trebuchet MS");
	listArray[7] = mytoolbar2.createListItem("Verdana", "Verdana", "Verdana");
	mytoolbar2.createList("font", "Font", listArray, 100);
	var listArray = new Array();
	listArray[0] = mytoolbar2.createListItem("1", "Smaller", "1");
	listArray[1] = mytoolbar2.createListItem("2", "Small", "2");
	listArray[2] = mytoolbar2.createListItem("3", "Normal", "3");
	listArray[3] = mytoolbar2.createListItem("4", "Large", "4");
	listArray[4] = mytoolbar2.createListItem("5", "Larger", "5");
	mytoolbar2.createList("size", "Size", listArray, 100);	
	var listArray = new Array();
	listArray[0] = mytoolbar2.createListItem("h1", "Site Title", "h1");
	listArray[1] = mytoolbar2.createListItem("h2", "Page Title", "h2");
	listArray[2] = mytoolbar2.createListItem("h3", "Header", "h3");
	listArray[3] = mytoolbar2.createListItem("h4", "Footer", "h4");
	listArray[4] = mytoolbar2.createListItem("h5", "Legal", "h5");
	mytoolbar2.createList("format", "Format", listArray, 100);
	var listArray = new Array();
	listArray[0] = mytoolbar2.createListItem("blue", "Blue", "blue");
	listArray[1] = mytoolbar2.createListItem("green", "Green", "green");
	listArray[2] = mytoolbar2.createListItem("yellow", "Yellow", "yellow");
	listArray[3] = mytoolbar2.createListItem("orange", "Orange", "orange");
	listArray[4] = mytoolbar2.createListItem("red", "Red", "red");
	listArray[5] = mytoolbar2.createListItem("purple", "Purple", "purple");
	listArray[6] = mytoolbar2.createListItem("gray", "Gray", "gray");
	listArray[7] = mytoolbar2.createListItem("black", "Black", "black");
	mytoolbar2.createList("color", "Color", listArray, 100);

	//myeditor.oncontextmenu = showMenu;
	}

	function doCmds(itemID)
	{
		if (itemID.indexOf("_") != -1)
		{
			var cmd = itemID.split("_");
			var type = cmd[0];
			var value = cmd[1];
		}
		else
		{
			var obj = document.getElementById(itemID);
			var type = obj.id;
			var value = obj.value
		}
		switch(type)
		{
			case "do":
			{
				if (value == "Open")
					myeditor.loadHTMLFile();
				if (value == "Save")
					alert ("Data to save: \n" + myeditor.getHTML());
				break;
			}
			case "style":
			{
				myeditor.changeStyle(value);
				break;
			}
			case "insert":
			{
				if (value == "Image")
				{
					myeditor.insertImage();
				}
				if (value == "Link")
					myeditor.insertLink();
				break;
			}
			case "font":
			{
				myeditor.changeFont(value);
				break;
			}
			case "size":
			{
				myeditor.changeSize(value);
				break;
			}
			case "format":
			{
				myeditor.changeFormat(value);
				break;
			}
			case "color":
			{
				myeditor.changeColor(value);
				break;
			}
			case "toggle":
			{
				myeditor.toggleView();
				break;
			}
		}
		if (itemID.indexOf("_") == -1)
		{
			document.getElementById(itemID).selectedIndex = 0;
		}
	}
