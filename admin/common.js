function XMLEncode(xmldata)
{
	xmldata = xmldata.replace(re, "&lt;");
	xmldata = xmldata.replace(re, "&gt;");
	xmldata = xmldata.replace(re, "'");
	xmldata = xmldata.replace(re, "&amp;");
	return xmldata;
}

function replace(oldstring, match, newchar)
{
	var FC = oldstring.substr(0, 1);
	var LC = oldstring.substr(oldstring.length-1, 1);
	var oldParts = oldstring.split(match);
	var newString = "";
	for (var j=0;j<oldParts.length;j++)
	{
		if (oldParts[j-1] == null)
		{
			newString += oldParts[j];
		}
		else
		{
			newString += newchar + oldParts[j];
		}
	}
	return newString;
}