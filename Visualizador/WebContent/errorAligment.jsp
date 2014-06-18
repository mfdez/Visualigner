<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=windows-1252"> 
<title>Error reading alignment</title>
<link rel="stylesheet" type="text/css" href="css/estilosError.css" media="screen, projection, tv " />
</head>
<body>
<%
Object o_mensajes=session.getAttribute("mensaje");
%>
<div id="header">

<span class="title">
	Visu<span class="white">Aligner</span>
</span>

<span class="subTitle">Ontology Alignment Display Web-Tool</span>

</div>

<div id="contenedor">

<div id='cssmenu'>
<ul>
   <li><a href='Index.html'><span>Home</span></a></li>
   <li><a href='#'><span>How To Use Visualigner</span></a></li>
   <li><a href='#'><span>About Visualigner</span></a></li>
   <li class='last'><a href='#'><span>Contact</span></a></li>
</ul>
</div>


<p> ERROR: The alignment <% out.print(o_mensajes.toString()); %> could not be loaded <p/>
</div>
</body>
</html>