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
<title>SwitchToMatrix</title> 
</head> 
<body>

<%

Logger logger = Logger.getLogger("CambiarAMatriz.jsp");

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

//numero de celdas que se van a recibir
int numeroCells = Integer.parseInt(request.getParameter("celdas"));

int i;
//Se construye el alignment con los elemenos de las celdas recibidos
for(i = 0; i < numeroCells; i++) {
	
	String elementOnt1 = request.getParameter("onto1elem" + String.valueOf(i));
	URI cls1 = URI.create(elementOnt1);	
	String elementOnt2 = request.getParameter("onto2elem" + String.valueOf(i));
	URI cls2 = URI.create(elementOnt2);
	String relation = request.getParameter("relation" + String.valueOf(i));
	Double measure = Double.parseDouble(request.getParameter("measure" + String.valueOf(i)));
	alineamiento.addAlignCell(cls1, cls2, relation, measure);
	
}

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
	<jsp:forward page = "Matriz.jsp" />
<%

%>
</body>
</html>