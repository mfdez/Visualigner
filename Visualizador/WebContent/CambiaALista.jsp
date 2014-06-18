<%@ page import="java.util.*,
java.io.*,
java.lang.Iterable,
java.net.URI,
java.lang.Exception" %>
<%@ page import=" org.semanticweb.owl.align.Alignment,
org.semanticweb.owl.align.AlignmentProcess,
org.semanticweb.owl.align.AlignmentException,
org.semanticweb.owl.align.AlignmentVisitor,
org.semanticweb.owl.align.Cell,
org.semanticweb.owl.align.Relation,

fr.inrialpes.exmo.align.parser.AlignmentParser,
fr.inrialpes.exmo.align.impl.BasicAlignment,
fr.inrialpes.exmo.align.impl.BasicCell,
fr.inrialpes.exmo.align.impl.renderer.RDFRendererVisitor,

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
<title>SwitchToList</title> 
</head> 
<body>

<%

Logger logger = Logger.getLogger("CambiaALista.jsp");

BasicAlignment alineamiento = new BasicAlignment();
String uri1 = null;
String uri2 = null;
String uriAlignment = "";
String fileName = "";
String verClases = null;
String verPropiedades = null;
String verIndividuos = null;

//Lee los path de los ficheros de las ontologias y del alignment
uri1 = session.getAttribute("uriOnt1").toString();
uri2 = session.getAttribute("uriOnt2").toString();
uriAlignment = session.getAttribute("uriAlign").toString();
fileName = session.getAttribute("fileTemp").toString();
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

//borrar las celdas del alignment
alineamiento.deleteAllCells();


//Obtiene uris de las ontologias
out.print("URIS de las ontologias");
out.print("<br/>");
String uriOnto1 = alineamiento.getOntology1URI().toString();
out.print(uriOnto1);
out.print("<br/>");
String uriOnto2 = alineamiento.getOntology2URI().toString();
out.print(uriOnto2);
out.print("<br/><br/>");


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
		if (uriClass1.contains(uriOnto1) ){
			rscClassesOnt1.add(claseOnt1);
		}
	}	
}

if (verPropiedades != "no") {
	while (propiedades.hasNext()) {
		OntProperty propiedadOnt1 = propiedades.next();
		String uriProp1 = propiedadOnt1.toString();
		if (uriProp1.contains(uriOnto1)) {
			rscPropOnt1.add(propiedadOnt1);
		}
	}
}

if (verIndividuos != "no") {
	while (individuos.hasNext()) {
		Individual individuoOnt1 = individuos.next();
		String uriInd1 = individuoOnt1.toString();
		if (uriInd1.contains(uriOnto1)) {
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
		if (uriClass2.contains(uriOnto2)) {
			rscClassesOnt2.add(claseOnt2);
		}
	}
}

if (verPropiedades != "no") {
	while (propiedades2.hasNext()) {
		OntProperty propiedadOnt2 = propiedades2.next();
		String uriProp2 = propiedadOnt2.toString();
		if (uriProp2.contains(uriOnto2)) {
			rscPropOnt2.add(propiedadOnt2);
		}
	}
}

if (verIndividuos != "no") {
	while (individuos2.hasNext()) {
		Individual individuoOnt2 = individuos2.next();
		String uriInd2 = individuoOnt2.toString();
		if (uriInd2.contains(uriOnto1)) {
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

//Se transforman en array para recorrerlos con los indices
Object[] arrayOnt1 = rscOnt1.toArray();
Object[] arrayOnt2 = rscOnt2.toArray();

//Se construye el alignment con los elemenos de las celdas recibidos
int longitudELemOnt1 = arrayOnt1.length;
int longitudELemOnt2 = arrayOnt2.length;
int i = 0;
int j = 0;


for (j = 0; j < longitudELemOnt2; j++) {
	String elementOnt2 = arrayOnt2[j].toString();
	for (i = 0; i < longitudELemOnt1; i++) {
		String elementOnt1 = arrayOnt1[i].toString();
		String relation = request.getParameter("relation" + (String.valueOf((j * longitudELemOnt1) + i)));
		if (relation != "" ) {
			Double measure = Double.parseDouble(request.getParameter("measure" + String.valueOf((j * (longitudELemOnt1)) + i)));
			URI cls1 = URI.create(elementOnt1);
    		URI cls2 = URI.create(elementOnt2);
			alineamiento.addAlignCell(cls1, cls2, relation, measure);
		}
	}
}

//Escribir el alignment a un fichero
try {
	OutputStream stream = new FileOutputStream(fileName);
	Writer writer = new OutputStreamWriter(stream, "UTF-8");
	BufferedWriter buffer = new BufferedWriter(writer);
	PrintWriter escritor = new PrintWriter(buffer, true);
	AlignmentVisitor renderizador = new RDFRendererVisitor(escritor);
	alineamiento.render((AlignmentVisitor) renderizador);
	escritor.flush();
	escritor.close();
} catch (AlignmentException e) {
%>
	<jsp:forward page = "errorEscAl.jsp" />
<%
}

//Cambiamos a la pagina que queremos
session.setAttribute("uriOnt1",uri1);
session.setAttribute("uriOnt2",uri2);
session.setAttribute("uriAlign",fileName);

%>
	<jsp:forward page = "Lista.jsp" />
<%

%>
</body>
</html>