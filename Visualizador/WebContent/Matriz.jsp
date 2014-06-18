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
com.hp.hpl.jena.rdf.model.AnonId,
com.hp.hpl.jena.util.iterator.ExtendedIterator" %>
<% 

Logger logger = Logger.getLogger("Matriz.jsp");

BasicAlignment alineamiento = new BasicAlignment();
String uri1 = null;
String uri2 = null;
String uriAlignment ="";
String verClases = null;
String verPropiedades = null;
String verIndividuos = null;

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

//Crea el parser del alignment
AlignmentParser lector = new AlignmentParser (0);

//Lee el alignment
try {
	alineamiento = (BasicAlignment) lector.parse (uriAlignment);
}
catch (AlignmentException e) {
	session.setAttribute("mensaje",uriAlignment);
%>
	<jsp:forward page = "errorAligment.jsp" />
<%

}
finally {
}

//Crea el array de cells para almacenar las cells del alignment
ArrayList<Cell> arrayCell = new ArrayList<Cell>();
arrayCell = alineamiento.getArrayElements();

//Obtiene uris de las ontologias
String uriOnto1 = alineamiento.getOntology1URI().toString();
String uriOnto2 = alineamiento.getOntology2URI().toString();

//Lee las ontologias
ArrayList<String> labelsOnt1 = new ArrayList<String>();

ArrayList<String> labelsClassesOnt1 = new ArrayList<String>();

ArrayList<String> labelsPropOnt1 = new ArrayList<String>();

ArrayList<String> labelsIndOnt1 = new ArrayList<String>();

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
		if (uriClass1.contains(uriOnto1) ){
			String labelClass1 = claseOnt1.getLabel(null);
			if (labelClass1 == null) {
				labelClass1 = claseOnt1.getLocalName();
			}
			labelsClassesOnt1.add(labelClass1);
			rscClassesOnt1.add(claseOnt1);
		}
	}
}

if (verPropiedades != "no") {
	while (propiedades.hasNext()) {
		OntProperty propiedadOnt1 = propiedades.next();
		String uriProp1 = propiedadOnt1.toString();
		if (uriProp1.contains(uriOnto1)) {
			String labelProp1 = propiedadOnt1.getLabel(null);
			if (labelProp1 == null) {
				labelProp1 = propiedadOnt1.getLocalName();
			}
			labelsPropOnt1.add(labelProp1);
			rscPropOnt1.add(propiedadOnt1);
		}
	}
}

if (verIndividuos != "no") {
	while (individuos.hasNext()) {
		Individual individuoOnt1 = individuos.next();
		String uriInd1 = individuoOnt1.toString();
		if (uriInd1.contains(uriOnto1)) {
			String labelInd1 = individuoOnt1.getLabel(null);
			if (labelInd1 == null) {
				labelInd1 = individuoOnt1.getLocalName();
			}
			labelsIndOnt1.add(labelInd1);
			rscIndOnt1.add(individuoOnt1);
		}
	}
}

ArrayList<String> labelsOnt2 = new ArrayList<String>();

ArrayList<String> labelsClassesOnt2 = new ArrayList<String>();

ArrayList<String> labelsPropOnt2 = new ArrayList<String>();

ArrayList<String> labelsIndOnt2 = new ArrayList<String>();

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
		if (uriClass2.contains(uriOnto2)) {
			String labelClass2 = claseOnt2.getLabel(null);
			if (labelClass2 == null) {
				labelClass2 = claseOnt2.getLocalName();
			}
			labelsClassesOnt2.add(labelClass2);
			rscClassesOnt2.add(claseOnt2);
		}
	}
}

if (verPropiedades != "no") {
	while (propiedades2.hasNext()) {
		OntProperty propiedadOnt2 = propiedades2.next();
		String uriProp2 = propiedadOnt2.toString();
		if (uriProp2.contains(uriOnto2)) {
			String labelProp2 = propiedadOnt2.getLabel(null);
			if (labelProp2 == null) {
				labelProp2 = propiedadOnt2.getLocalName();
			}
			labelsPropOnt2.add(labelProp2);
			rscPropOnt2.add(propiedadOnt2);
		}
	}
}

if (verIndividuos != "no") {
	while (individuos2.hasNext()) {
		Individual individuoOnt2 = individuos2.next();
		String uriInd2 = individuoOnt2.toString();
		if (uriInd2.contains(uriOnto1)) {
			String labelInd2 = individuoOnt2.getLabel(null);
			if (labelInd2 == null){
				labelInd2 = individuoOnt2.getLocalName();
			}
			labelsIndOnt2.add(labelInd2);
			rscIndOnt2.add(individuoOnt2);
		}
	}
}

labelsOnt1.addAll(labelsClassesOnt1);

labelsOnt1.addAll(labelsPropOnt1);

labelsOnt1.addAll(labelsIndOnt1);

labelsOnt2.addAll(labelsClassesOnt2);

labelsOnt2.addAll(labelsPropOnt2);

labelsOnt2.addAll(labelsIndOnt2);

rscOnt1.addAll(rscClassesOnt1);

rscOnt1.addAll(rscPropOnt1);

rscOnt1.addAll(rscIndOnt1);

rscOnt2.addAll(rscClassesOnt2);

rscOnt2.addAll(rscPropOnt2);

rscOnt2.addAll(rscIndOnt2);

int indexElem1 = 0;
int indexElem2 = 0;
	
int index1 = labelsOnt1.size();
int index2 = labelsOnt2.size();

String [][] matrixRel = new String [index1][index2];
double [][] matrixMeasures = new double[index1][index2];

for (Cell c: arrayCell) {
	String elem1 = "";
	String elem2 = "";
    String elemento1 = c.getObject1().toString();
	OntResource resOnt1 = modelOnt1.getOntResource(elemento1);
	if (resOnt1 == null) {
%>
		<jsp:forward page="errorOnt1.jsp" />
<%
	}
	else { 
    	elem1 = resOnt1.getLabel(null);
    	if (elem1 == null) {
  			int posicion1 = elemento1.lastIndexOf("#");
  	   		elem1 = elemento1.substring (posicion1 + 1);
  		}
		indexElem1 = rscOnt1.indexOf(resOnt1);
		if (indexElem1 == -1) {
			continue;
		}
	}
	String elemento2 = c.getObject2().toString();
	OntResource resOnt2 = modelOnt2.getOntResource(elemento2);
	if (resOnt2 == null) {
%>
		<jsp:forward page="errorOnt2.jsp" />
<%
	}
	else { 
    	elem2 = resOnt2.getLabel(null);
	   	if (elem2 == null) {
	    	int posicion2 = elemento2.lastIndexOf("#");
	    	elem2 = elemento2.substring (posicion2 + 1);
  		}
	   	indexElem2 = rscOnt2.indexOf(resOnt2);
		if (indexElem2 == -1) {
			continue;
		}
	}
	
	String relacion = c.getRelation().toString();
	if (relacion.contains("EquivRelation")) {
		matrixRel[indexElem1][indexElem2] = "=";
	}
	else if (relacion.contains("SubsumedRelation")) {
		matrixRel[indexElem1][indexElem2] = "<";
	}
	else if (relacion.contains("SubsumeRelation")){
	   	matrixRel[indexElem1][indexElem2] = ">";
	}
		
	matrixMeasures[indexElem1][indexElem2] = c.getStrength();

}	

if ((index1 > 4) && (index2 > 13)) { 
%>


<html> 
<head> 
<title>Matrix</title>

<script type="text/javascript" src="./color.js"></script>
<script type="text/javascript" src="./jquery-1.7.2.min.js"></script>
<script>
    $(function() {
        $.fn.cTable = function(o) {        

            this.wrap('<div class="cTContainer" />');
            this.wrap('<div class="relativeContainer" />');    
            //Update below template as how you have it in orig table
            var origTableTmpl = '<table border="1" cellspacing="1" cellpadding="0" align="center" width="95%" ></table>';            
            //get row 1 and clone it for creating sub tables
            var row1 = this.find('tr').slice(0, o.fRows).clone();

            var r1c1ColSpan = 0;
            for (var i = 0; i < o.fCols; i++ ) {
                r1c1ColSpan += this[0].rows[0].cells[i].colSpan;
            }

            //create table with just r1c1 which is fixed for both scrolls
            var tr1c1 = $(origTableTmpl);
            row1.each(function () {            
                var tdct = 0;
                $(this).find('td').filter( function () {
                    tdct += this.colSpan;
                    return tdct > r1c1ColSpan;
                }).remove();                
            });
            row1.appendTo(tr1c1);
            tr1c1.wrap('<div class="fixedTB" />');
            tr1c1.parent().prependTo(this.closest('.relativeContainer'));

            //create a table with just c1        
            var c1= this.clone().prop({'id': ''});
            c1.find('tr').slice(0, o.fRows).remove();
            c1.find('tr').each(function (idx) {
                var c = 0;
                $(this).find('td').filter(function () {
                    c += this.colSpan;
                    return c > r1c1ColSpan;
                }).remove();           
            });

            var prependRow = row1.first().clone();
            prependRow.find('td').empty();
            c1.prepend(prependRow).wrap('<div class="leftSBWrapper" />')
            c1.parent().wrap('<div class="leftContainer" />');            
            c1.closest('.leftContainer').insertAfter('.fixedTB');

            //create table with just row 1 without col 1
            var r1 = $(origTableTmpl);
            row1 = this.find('tr').slice(0, o.fRows).clone();
            row1.each(function () {
                var tds = $(this).find('td'), tdct = 0;
                tds.filter (function () {
                    tdct += this.colSpan;
                    return tdct <= r1c1ColSpan;
                }).remove();
            });
            row1.appendTo(r1);
            r1.wrap('<div class="topSBWrapper" />')
            r1.parent().wrap('<div class="rightContainer" />')  
            r1.closest('.rightContainer').appendTo('.relativeContainer');

            $('.relativeContainer').css({'width': 'auto', 'height': o.height});

            this.wrap('<div class="SBWrapper"> /')        
            this.parent().appendTo('.rightContainer');    
            this.prop({'width': o.width});    

            var tw = 0;
            //set width and height of rendered tables
            for (var i = 0; i < o.fCols; i++) {
                tw += $(this[0].rows[0].cells[i]).outerWidth(true);
            }
            tr1c1.width(tw);
            c1.width(tw);

            $('.rightContainer').css('left', tr1c1.outerWidth(true));

            for (var i = 0; i < o.fRows; i++) {
                var tr1c1Ht = $(c1[0].rows[i]).outerHeight(true);
                var thisHt = $(this[0].rows[i]).outerHeight(true);
                var finHt = (tr1c1Ht > thisHt)?tr1c1Ht:thisHt;
                $(tr1c1[0].rows[i]).height(finHt);
                $(r1[0].rows[i]).height(finHt);
            }
            $('.leftContainer').css({'top': tr1c1.outerHeight(true), 'width': tr1c1.outerWidth(true)});

            var rtw = $('.relativeContainer').width() - tw;
            $('.rightContainer').css({'width' : rtw, 'height': o.height, 'max-width': o.width - tw});    

            var trs = this.find('tr');
            trs.slice(1, o.fRows).remove();
            trs.slice(0, 1).find('td').empty();
            trs.each(function () {
                var c = 0;
                $(this).find('td').filter(function () {
                    c += this.colSpan;
                    return c <= r1c1ColSpan;
                }).remove();
            });

            r1.width(this.outerWidth(true));

            for (var i = 1; i < c1[0].rows.length; i++) {
                var c1Ht = $(c1[0].rows[i]).outerHeight(true);
                var thisHt = $(this[0].rows[i]).outerHeight(true);
                var finHt = (c1Ht > thisHt)?c1Ht:thisHt;
                $(c1[0].rows[i]).height(finHt);
                $(this[0].rows[i]).height(finHt);
            }

            $('.SBWrapper').css({'height': $('.relativeContainer').height() - $('.topSBWrapper').height()});            

            $('.SBWrapper').scroll(function () {
                var rc = $(this).closest('.relativeContainer');
                var lfW = rc.find('.leftSBWrapper');
                var tpW = rc.find('.topSBWrapper');

                lfW.css('top', ($(this).scrollTop()*-1));
                tpW.css('left', ($(this).scrollLeft()*-1));        
            });

            $(window).resize(function () {
                $('.rightContainer').width(function () {
                    return $(this).closest('.relativeContainer').outerWidth() - $(this).siblings('.leftContainer').outerWidth();
                });

            });
        }

        $('#cTable').cTable({
            width: 1300,
            height: 800,
            fCols: 1,
            fRows: 1
        });
    });
</script>
<script> 
function saveAlignment(){
	document.formularioM.action = "http://localhost:8080/Visualizador/saveMatrix"
	document.formularioM.submit() 
} 
</script>
<script> 
function switchList(){
	document.formularioM.action = "CambiaALista.jsp"
	document.formularioM.submit() 
} 
</script> 
<link rel="stylesheet" type="text/css" href="css/estilosMatricesS.css" media="screen, projection, tv " />
</head> 

<body> 

<div id='cssmenu'>
<ul>
   <li><a href='Index.html'><span>Home</span></a></li>
   <li><a href='#'><span>How To Use Visualigner</span></a></li>
   <li><a href='#'><span>About Visualigner</span></a></li>
   <li><a href='#'><span>Contact</span></a></li>
   <li><a href="javascript:saveAlignment()">Save Alignment</a></li>
   <li class='last'><a href="javascript:switchList()">List</a></li>
</ul>
</div>
<br>

<form action="" method="post" name="formularioM" id="formularioM">

<table  width="95%" cellspacing="1" cellpadding="0" align="center" id="cTable" >
<%
}
else {
%>

<html> 
<head> 
<title>Matrix</title>

<script type="text/javascript" src="./color.js"></script>
<script> 
function saveAlignment(){
	document.formularioM.action = "http://localhost:8080/Visualizador/saveMatrix"
	document.formularioM.submit() 
} 
</script>
<script> 
function switchList(){
	document.formularioM.action = "CambiaALista.jsp"
	document.formularioM.submit() 
} 
</script> 
<link rel="stylesheet" type="text/css" href="css/estilosMatrices.css" media="screen, projection, tv " />
</head> 
<body> 

<form action="" method="post" name="formularioM" id="formularioM">

<div id='cssmenu'>
<ul>
   <li><a href='Index.html'><span>Home</span></a></li>
   <li><a href='#'><span>How To Use Visualigner</span></a></li>
   <li><a href='#'><span>About Visualigner</span></a></li>
   <li><a href='#'><span>Contact</span></a></li>
   <li><a href="javascript:saveAlignment()">Save Alignment</a></li>
   <li class='last'><a href="javascript:switchList()">List</a></li>
</ul>
</div>

<table id = "AdyacencyMatrix">

<%
}
%>
<tbody><tr><td class="cabeceraFila">Adjacency Matrix</td>
<%
Iterator<String> elemOnt1Iterator = labelsOnt1.iterator();
while(elemOnt1Iterator.hasNext()) {
	String s = elemOnt1Iterator.next();
%>
<td class="cabeceraFila">
<p><%	out.print(s);
%></p>
</td>
<%
}
%>
</tr>
<%
int ind2 = 0;

for (int j = 0; j < labelsOnt2.size(); j++) {
	String s2 = labelsOnt2.get(j);
%>
<tr>
<td class="cabeceraFila">
<p><%	out.print(s2);
%></p>
</td>
<% 	
	for (int i = 0; i < labelsOnt1.size(); i++) {
		if (matrixMeasures[i][j] != 0) {
			String rel = matrixRel[i][j];
			String val = String.valueOf(matrixMeasures[i][j]);
			String simbol = rel;
			
%>			<td id="cell<%out.print(String.valueOf(ind2)); %>" bgcolor = "#8B0000">
			<select name="relation<%out.print(String.valueOf(ind2)); %>" id="relation<%out.print(String.valueOf(ind2)); %>" 
					onchange="colorear('cell<%out.print(String.valueOf(ind2)); %>', 'measure<%out.print(String.valueOf(ind2)); %>', 'relation<%out.print(String.valueOf(ind2)); %>')">
<%              if (simbol == "=") { %>
                    <option selected="selected" value= "="> &#61</option>
<%              }
                else {  %>
                    <option value= "="> &#61</option>
<%              }
                if (simbol == "<") { %>
                    <option selected="selected" value= "<"> &#60</option>
<%              }
                else {  %>
                    <option value= "<"> &#60</option>
<%              }
                if (simbol == ">") { %>
                    <option selected="selected" value= ">"> &#62</option>
<%              }
                else {  %>
                    <option value= ">"> &#62</option>
<%              } %>
					<option value= ""> </option>
            </select>
			<input type="text" name="measure<%out.print(String.valueOf(ind2)); %>" id="measure<%out.print(String.valueOf(ind2));%>" value="<%= val%>"
				   onchange="colorear('cell<%out.print(String.valueOf(ind2)); %>', 'measure<%out.print(String.valueOf(ind2)); %>', 'relation<%out.print(String.valueOf(ind2)); %>')">
			 </td>
<%
		}
		else {
%>
			<td id="cell<%out.print(String.valueOf(ind2)); %>">
			<select name="relation<%out.print(String.valueOf(ind2)); %>" id="relation<%out.print(String.valueOf(ind2)); %>" 
					onchange="colorear('cell<%out.print(String.valueOf(ind2)); %>', 'measure<%out.print(String.valueOf(ind2)); %>', 'relation<%out.print(String.valueOf(ind2)); %>')">
                    <option value= ""> </option>
                    <option value= "="> &#61</option>
                    <option value= "<"> &#60</option>
                    <option value= ">"> &#62</option>
             </select>
			<input type="text" name="measure<%out.print(String.valueOf(ind2)); %>" id="measure<%out.print(String.valueOf(ind2));%>" value="0"
			       onchange="colorear('cell<%out.print(String.valueOf(ind2)); %>', 'measure<%out.print(String.valueOf(ind2)); %>', 'relation<%out.print(String.valueOf(ind2)); %>')">
			</td>
<%
		}
		ind2++;
	}
%>
</tr>
<%
}

%>
</tbody>
</table>

<input type="hidden"
	   name="celdas"
	   value="<%out.print(String.valueOf(ind2));%>">
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
</form>
</body> 
</html> 