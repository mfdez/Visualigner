<%@ page import="java.util.*,
java.lang.Iterable,
java.net.URI,
java.lang.Exception" %>
<%@ page import=" org.semanticweb.owl.align.Alignment,
org.semanticweb.owl.align.AlignmentProcess,
org.semanticweb.owl.align.AlignmentException,
org.semanticweb.owl.align.Cell,
org.semanticweb.owl.align.Relation,

fr.inrialpes.exmo.align.parser.AlignmentParser,
fr.inrialpes.exmo.align.impl.BasicAlignment,
fr.inrialpes.exmo.align.impl.BasicCell,

com.hp.hpl.jena.ontology.OntModel,
com.hp.hpl.jena.ontology.OntModelSpec,
com.hp.hpl.jena.ontology.OntResource,
com.hp.hpl.jena.ontology.OntClass,
com.hp.hpl.jena.ontology.OntProperty,
com.hp.hpl.jena.ontology.Individual,

org.apache.log4j.Logger,

com.hp.hpl.jena.rdf.model.Literal,
com.hp.hpl.jena.rdf.model.ModelFactory,
com.hp.hpl.jena.rdf.model.Property,
com.hp.hpl.jena.rdf.model.RDFNode,

com.hp.hpl.jena.util.iterator.ExtendedIterator" %>

<html> 
<head> 
<title>List</title>
<!--[if lt IE 9]>
	<link href="none.css" rel="stylesheet" type="text/css" />
<![endif]-->

<script> 
function saveAlignment(){
	document.formularioL.action = "http://localhost:8080/Visualizador/saveList"
	document.formularioL.submit() 
} 
</script>
<script> 
function switchMatrix(){
	document.formularioL.action = "CambiarAMatriz.jsp"
	document.formularioL.submit() 
} 
</script> 
<script> 
function addCell(){
	document.formularioL.action = "SumarFila.jsp"
	document.formularioL.submit() 
} 
</script>
<script> 
function deleteCells(){
	document.formularioL.action = "BorrarFila.jsp"
	document.formularioL.submit() 
} 
</script>

<link rel="stylesheet" type="text/css" href="css/estilosListas.css" media="screen, projection, tv " />
</head> 
<body> 

<% 

Logger logger = Logger.getLogger("Lista.jsp");

String uri1 = null;
String uri2 = null;
String uriAlignment = "";
String verClases = null;
String verPropiedades = null;
String verIndividuos = null;

//Lee los path de los ficheros de las ontologias y del alignment
uri1 = session.getAttribute("uriOnt1").toString();
uri2 = session.getAttribute("uriOnt2").toString();
uriAlignment = session.getAttribute("uriAlign").toString();
verClases = session.getAttribute("verC").toString();
verPropiedades = session.getAttribute("verP").toString();
verIndividuos = session.getAttribute("verI").toString();

//Crea los respectivos modelos y lee las dos ontologias
OntModel modelOnt1 = ModelFactory.createOntologyModel();
OntModel modelOnt2 = ModelFactory.createOntologyModel();

modelOnt1.read(uri1);
modelOnt2.read(uri2);

//Obtiene uris de las ontologias

String consUriOnto1 = request.getParameter("consUriOnt1").toString();

String consUriOnto2 = request.getParameter("consUriOnt2").toString();

//Lee las ontologias

ArrayList<OntResource> rscOnt1 = new ArrayList<OntResource>();

ArrayList<OntResource> rscClassesOnt1 = new ArrayList<OntResource>();

ArrayList<OntResource> rscPropOnt1 = new ArrayList<OntResource>();

ArrayList<OntResource> rscIndOnt1 = new ArrayList<OntResource>();

ExtendedIterator<OntClass> clases = modelOnt1.listClasses();

ExtendedIterator<OntProperty> propiedades = modelOnt1.listAllOntProperties();

ExtendedIterator<Individual> individuos = modelOnt1.listIndividuals();

if (verClases != "no") {
	while (clases.hasNext()) {
		OntClass claseOnt1 = clases.next();
		String uriClass1 = claseOnt1.toString();
		if (uriClass1.contains(consUriOnto1)) {
			String labelClass1 = claseOnt1.getLabel(null);
			if (labelClass1 == null) {
				labelClass1 = claseOnt1.getLocalName();
			}
			rscClassesOnt1.add(claseOnt1);
		}
	}
}

if (verPropiedades != "no") {
	while (propiedades.hasNext()) {
		OntProperty propiedadOnt1 = propiedades.next();
		String uriProp1 = propiedadOnt1.toString();
		if (uriProp1.contains(consUriOnto1)) {
			String labelProp1 = propiedadOnt1.getLabel(null);
			if (labelProp1 == null) {
				labelProp1 = propiedadOnt1.getLocalName();
			}
			rscPropOnt1.add(propiedadOnt1);
		}
	}
}

if (verIndividuos != "no") {
	while (individuos.hasNext()) {
		Individual individuoOnt1 = individuos.next();
		String uriInd1 = individuoOnt1.toString();
		if (uriInd1.contains(consUriOnto1)) {
			String labelInd1 = individuoOnt1.getLabel(null);
			if (labelInd1 == null){
				labelInd1 = individuoOnt1.getLocalName();
			}
			rscIndOnt1.add(individuoOnt1);
		}
	}
}

ArrayList<OntResource> rscOnt2 = new ArrayList<OntResource>();

ArrayList<OntResource> rscClassesOnt2 = new ArrayList<OntResource>();

ArrayList<OntResource> rscPropOnt2 = new ArrayList<OntResource>();

ArrayList<OntResource> rscIndOnt2 = new ArrayList<OntResource>();

ExtendedIterator<OntClass> clases2 = modelOnt2.listClasses();

ExtendedIterator<OntProperty> propiedades2 = modelOnt2.listAllOntProperties();

ExtendedIterator<Individual> individuos2 = modelOnt2.listIndividuals();

if (verClases != "no") {
	while (clases2.hasNext()) {
		OntClass claseOnt2 = clases2.next();
		String uriClass2 = claseOnt2.toString();
		if (uriClass2.contains(consUriOnto2)) {
			String labelClass2 = claseOnt2.getLabel(null);
			if (labelClass2 == null){
				labelClass2 = claseOnt2.getLocalName();
			}
			rscClassesOnt2.add(claseOnt2);
		}
	}
}
	
if (verPropiedades != "no") {
	while (propiedades2.hasNext()) {
		OntProperty propiedadOnt2 = propiedades2.next();
		String uriProp2 = propiedadOnt2.toString();
		if (uriProp2.contains(consUriOnto2)) {
			String labelProp2 = propiedadOnt2.getLabel(null);
			if (labelProp2 == null){
				labelProp2 = propiedadOnt2.getLocalName();
			}
			rscPropOnt2.add(propiedadOnt2);
		}
	}
}
	
if (verIndividuos != "no") {
	while (individuos2.hasNext()) {
		Individual individuoOnt2 = individuos2.next();
		String uriInd2 = individuoOnt2.toString();
		if (uriInd2.contains(consUriOnto2)) {
			String labelInd2 = individuoOnt2.getLabel(null);
			if (labelInd2 == null) {
				labelInd2 = individuoOnt2.getLocalName();
			}
			rscIndOnt2.add(individuoOnt2);
		}
	}
}
	
rscOnt1.addAll(rscClassesOnt1);

rscOnt1.addAll(rscPropOnt1);

rscOnt1.addAll(rscIndOnt1);

rscOnt2.addAll(rscClassesOnt2);

rscOnt2.addAll(rscPropOnt2);

rscOnt2.addAll(rscIndOnt2);

/* Para cada celda obtiene las uris de los elementos de la ontologias y de las ontologias
las etiqueta de los elementos. Si una etiqueta es vacia obtiene el localnamespace */ 

%>


<div id='cssmenu'>
<ul>
   <li><a href='Index.html'><span>Home</span></a></li>
   <li><a href='#'><span>How To Use Visualigner</span></a></li>
   <li><a href='#'><span>About Visualigner</span></a></li>
   <li><a href='#'><span>Contact</span></a></li>
   <li><a href="javascript:addCell()">Add Cell</a></li>
   <li><a href="javascript:deleteCells()">Delete Cells</a></li>
   <li><a href="javascript:saveAlignment()">Save Alignment</a></li>
   <li class='last'><a href="javascript:switchMatrix()">Matrix</a></li>
</ul>
</div>


<form action="" method="POST" name="formularioL" id="formularioL">

<table id = "Tablalist">
<tbody>
<%
int numeroCells = Integer.parseInt(request.getParameter("celdas"));

int ind = 0;
int i = 0;
for (i = 0; i < (numeroCells); i++) {
	String checkbox = request.getParameter("checkbox" + String.valueOf(i));
	if (checkbox == null) {
		%>
		<tr>
		<td>
		<select name="onto1elem<%out.print(String.valueOf(ind)); %>" id="onto1elem<%out.print(String.valueOf(ind)); %>">
		<%	String elemCellOnt1 = request.getParameter("onto1elem" + String.valueOf(i));
			OntResource resOnt1 = modelOnt1.getOntResource(elemCellOnt1);
		  	String labelElemOnt1 = resOnt1.getLabel(null);
			if (labelElemOnt1 == null) {
		  		int posLabel1 = elemCellOnt1.lastIndexOf("#");
		  		labelElemOnt1 = elemCellOnt1.substring (posLabel1 + 1);
		  	}
			Iterator<OntResource> iResourcesOnt1 = rscOnt1.iterator();
			while(iResourcesOnt1.hasNext()) {
				OntResource resourceOnt1 = iResourcesOnt1.next();
				if (resourceOnt1.equals(resOnt1)) {
		%>
					<option selected="selected" value=<%=resOnt1.getURI() %>><% out.print(labelElemOnt1); %></option>
		<%
				}
				else {
					String labelAux = resourceOnt1.getLabel(null);
					if (labelAux == null) {
						int posLabelAux = resourceOnt1.toString().lastIndexOf("#");
						labelAux = resourceOnt1.toString().substring (posLabelAux + 1);
					}
		%>
					<option value=<%=resourceOnt1.getURI() %>><% out.print(labelAux); %></option>
		<%
				}
			}

		%>
		</select>
		</td>
		<td>
		<select name="onto2elem<%out.print(String.valueOf(ind)); %>" id="onto2elem<%out.print(String.valueOf(ind)); %>">
		<%	String elemCellOnt2 = request.getParameter("onto2elem" + String.valueOf(i));
			OntResource resOnt2 = modelOnt2.getOntResource(elemCellOnt2);
		   	String labelElemOnt2 = resOnt2.getLabel(null);
		      if (labelElemOnt2 == null) {
			   	int posLabel2 = elemCellOnt2.lastIndexOf("#");
			   	labelElemOnt2 = elemCellOnt2.substring (posLabel2 + 1);
		      }

			Iterator<OntResource> iResourcesOnt2 = rscOnt2.iterator();
			while(iResourcesOnt2.hasNext()) {
				OntResource resourceOnt2 = iResourcesOnt2.next();
				if (resourceOnt2.equals(resOnt2)) {
		%>
					<option selected="selected" value=<%=resOnt2.getURI() %>><% out.print(labelElemOnt2); %></option>
		<%
				}
				else {
					String labelAux2 = resourceOnt2.getLabel(null);
					if (labelAux2 == null) {
						int posLabelAux2 = resourceOnt2.toString().lastIndexOf("#");
						labelAux2 = resourceOnt2.toString().substring (posLabelAux2 + 1);
					}
		%>
					<option value=<%=resourceOnt2.getURI() %>><% out.print(labelAux2); %></option>
		<%
				}
			}

		%>
		</select>
		</td>
		<td>
		<%	
			String simbol = request.getParameter("relation" + String.valueOf(i));
		%>
		<select name="relation<%out.print(String.valueOf(ind)); %>" id="relation<%out.print(String.valueOf(ind)); %>">
		<% 	if (simbol == "=") { %>
				<option selected="selected" value= "="> &#61</option>
		<%  }
			else {  %>
				<option value= "="> &#61</option>
		<% 	}
			if (simbol == "<") { %>
				<option selected="selected" value= "<"> &#60</option>
		<%  }
			else {  %>
				<option value= "<"> &#60</option>
		<% 	}
			if (simbol == ">") { %>
				<option selected="selected" value= ">"> &#62</option>
		<%  }
			else {  %>
				<option value= ">"> &#62</option>
		<%	} %>
		</select>
		</td>
		<td>
		<input type="text" name="measure<%out.print(String.valueOf(ind)); %>" id="measure<%out.print(String.valueOf(ind)); %>"
		 value="<%=String.valueOf(request.getParameter("measure" + String.valueOf(i)))%>" size="10" class="input">
		</td>
		<td>
		<input type="checkbox" name="checkbox<%out.print(String.valueOf(ind)); %>" value="check">
		</td>
		</tr>
		<%
		ind++;
	}
}
%>
</tbody>
</table>

<table id="Add" border="1">
<tbody>
<tr>
<td>
<select name="onto1elem<%out.print(String.valueOf(ind)); %>" id="onto1elem<%out.print(String.valueOf(ind)); %>">
<%	
Iterator<OntResource> iResourcesOnt1 = rscOnt1.iterator();
while(iResourcesOnt1.hasNext()) {
	OntResource resourceOnt1 = iResourcesOnt1.next();
	String labelAux = resourceOnt1.getLabel(null);
	if (labelAux == null) {
		int posLabelAux = resourceOnt1.toString().lastIndexOf("#");
		labelAux = resourceOnt1.toString().substring (posLabelAux + 1);
	}
%>
	<option value=<%=resourceOnt1.getURI() %>><% out.print(labelAux); %></option>
<%
}

%>
</select>
</td>
<td>
<select name="onto2elem<%out.print(String.valueOf(ind)); %>" id="onto2elem<%out.print(String.valueOf(ind)); %>">
<%	
Iterator<OntResource> iResourcesOnt2 = rscOnt2.iterator();
while(iResourcesOnt2.hasNext()) {
	OntResource resourceOnt2 = iResourcesOnt2.next();
	String labelAux2 = resourceOnt2.getLabel(null);
	if (labelAux2 == null) {
		int posLabelAux2 = resourceOnt2.toString().lastIndexOf("#");
		labelAux2 = resourceOnt2.toString().substring (posLabelAux2 + 1);
	}
%>
				<option value=<%=resourceOnt2.getURI() %>><% out.print(labelAux2); %></option>
<%
}
%>
</select>
</td>
<td>
<select name="relation<%out.print(String.valueOf(ind)); %>" id="relation<%out.print(String.valueOf(ind)); %>">
    <option> </option>
	<option value= "="> &#61</option>
	<option value= "<"> &#60</option>
	<option value= ">"> &#62</option>
</select>
</td>
<td>
<input type="text" name="measure<%out.print(String.valueOf(ind)); %>" id="measure<%out.print(String.valueOf(ind)); %>"
 value="0" size="10" class="input">
</td>
</tr>
</tbody>
</table>

<input type="hidden"
	   name="celdas"
	   id="celdas"
	   value="<%out.print(String.valueOf(ind));%>">	   
<input type="hidden"
	   name="uriOnt1"
	   id="uriOnt1"
	   value="<%out.print(uri1);%>">
<input type="hidden"
	   name="uriOnt2"
	   id="uriOnt2"
	   value="<%out.print(uri2);%>">	   
<input type="hidden"
	   name="uriAlignment"
	   id="uriAlignment"
	   value="<%out.print(uriAlignment);%>">
	   <input type="hidden"
	   name="consUriOnt1"
	   id="consUriOnt1"
	   value="<%out.print(consUriOnto1);%>">
<input type="hidden"
	   name="consUriOnt2"
	   id="consUriOnt2"
	   value="<%out.print(consUriOnto2);%>">
</form>
</body> 
</html> 