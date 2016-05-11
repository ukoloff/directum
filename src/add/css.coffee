#
# Просто CSS без всяких там
#
module.exports = """
body	{
 background:	#A0C0E0 URL(about:blank) no-repeat fixed;
 margin:	0;
 padding:	0.3ex;
 color:		black;
 font-family:	Verdana, Arial, sans-serif;
 text-align:	justify;
}

#Footer {
 position: fixed;
 bottom: 0;
 left: 0;
 width: 100%;
 font-size: 87%;
 white-space:nowrap;
 border-top: 1px dashed navy;
}

* html #Footer {
 position: absolute;
 left: expression(eval(document.documentElement.scrollLeft));
 width: expression(eval(document.documentElement.clientWidth));
 top: expression(document.documentElement.clientHeight-this.offsetHeight+document.documentElement.scrollTop);
 background: lime;
}

#C {
 background:	#B0D0F0;
}

#D {
 display:	none;
 background:	yellow;
 text-align:	center;
}

.Flip #C {
 display:	none;
}

.Flip #D {
 display:	block;
}

H1	{
 text-align:	right;
}

#pg1Btn {
 text-align:	right;
}

Table	{
 width: 100%;

}

THead, TFoot {
 background:	white;
}

TH	{
 text-align: center;
}

.Even	{
 background: #CCCCEE;
}

.Odd	{
 background: #AAAACC;
}

#Spinner {
 text-align:	center;
 padding:	0.3ex;
}

#Spinner Span {
 padding:	0 0.5ex;
 margin:	0 0.2ex;
 x-width:	1ex;
 border:	1px solid #EEEEEE;
}
"""
