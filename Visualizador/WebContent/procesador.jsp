<%@ page import="org.apache.commons.fileupload.*,
org.apache.commons.fileupload.servlet.ServletFileUpload,
org.apache.commons.fileupload.disk.DiskFileItemFactory,
org.apache.commons.io.FilenameUtils,
java.io.File,
java.io.InputStream,
java.util.*,
java.lang.Iterable,
java.net.URI,
java.lang.Exception" %>


<html> 
<head> 
<title>Procesador</title> 
</head> 
<body> 
<h1>Data Received at the Server</h1> 
 
<% 
String modoOntologia1 = "";
String urlOntologia1 = "";
String modoOntologia2 = "";
String urlOntologia2 = "";
String modoAlignment = "";
String urlAlignment = "";
String nameArchivoOntologia1 = "";
String nameArchivoOntologia2 = "";
String nameArchivoAlignment = "";
String modoVis = "";

String uri1 = null;
String uri2 = null;
String uriAlignment ="";
String verClases = "no";
String verPropiedades = "no";
String verIndividuos = "no";

/* Recoje los datos del formulario */
if (ServletFileUpload.isMultipartContent(request)){ 

	ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory()); 
	List fileItemsList = servletFileUpload.parseRequest(request); 
	FileItem fileItem = null; 
	Iterator it = fileItemsList.iterator();
	
	while (it.hasNext()) { // Si es un campo de texto lo guarda en la variable correspondiente
		FileItem fileItemTemp = (FileItem)it.next(); 
		if (fileItemTemp.isFormField()) {
			if (fileItemTemp.getFieldName().equals("modo1")) {
				modoOntologia1 = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("urlOntologia1")) {
				urlOntologia1 = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("modo2")) {
				modoOntologia2 = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("urlOntologia2")) { 
				urlOntologia2 = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("modoA")) {
				modoAlignment = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("urlAlignment")) { 
				urlAlignment = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("verClases")) { 
				verClases = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("verPropiedades")) { 
				verPropiedades = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("verIndividuos")) { 
				verIndividuos = fileItemTemp.getString();
			}
			else if (fileItemTemp.getFieldName().equals("modoVisualizacion")) { 
				modoVis = fileItemTemp.getString();
			}
%> 
<b>Name-value Pair Info:</b><br/>
Field name: <%= fileItemTemp.getFieldName() %><br/> 
Field value: <%= fileItemTemp.getString() %><br/><br/> 
<% 
		} 
		else {// Si es un archivo lo sube a una carpeta del servidor
			String fileName = fileItemTemp.getName(); 

/* Guarda el archivo subido si su tamaño es mayor que 0 */ 
			String dirName = "C:/Temp/"; 
			if (fileItemTemp.getSize() > 0) { 
				if (fileItemTemp.getFieldName().equals("archivoOntologia1")) {
					fileName = FilenameUtils.getName(fileName); 
					nameArchivoOntologia1 = dirName + fileName;
					File saveTo = new File(nameArchivoOntologia1);	
					try { 
						fileItemTemp.write(saveTo); 
%>

<b>Uploaded File Info:</b><br/> 
Content type: <%= fileItemTemp.getContentType() %><br/> 
Field name: <%= fileItemTemp.getFieldName() %><br/> 
File name: <%= fileItemTemp %><br/> 
File size: <%= fileItemTemp.getSize() %><br/><br/> 
 
<b>The uploaded file has been saved successfully.</b><br/> 
<% 
					} 
					catch (Exception e){ 
%> 
<b>An error occurred when we tried to save the uploaded file.</b> <br/>
<% 
					}
				}
				if (fileItemTemp.getFieldName().equals("archivoOntologia2")) {
					fileName = FilenameUtils.getName(fileName); 
					nameArchivoOntologia2 = dirName + fileName;
					File saveTo = new File(nameArchivoOntologia2);				
					try { 
						fileItemTemp.write(saveTo); 
%> 

<b>Uploaded File Info:</b><br/> 
Content type: <%= fileItemTemp.getContentType() %><br/> 
Field name: <%= fileItemTemp.getFieldName() %><br/> 
File name: <%= fileItemTemp %><br/> 
File size: <%= fileItemTemp.getSize() %><br/><br/> 

<b>The uploaded file has been saved successfully.</b> <br/>
<% 
					} 
					catch (Exception e) { 
%> 
<b>An error occurred when we tried to save the uploaded file.</b> <br/>
<% 
					}
				}
				if (fileItemTemp.getFieldName().equals("archivoAlignment")) {
					fileName = FilenameUtils.getName(fileName); 
					nameArchivoAlignment = dirName + fileName;
					File saveTo = new File(nameArchivoAlignment);	
					try { 
						fileItemTemp.write(saveTo); 
%> 

<b>Uploaded File Info:</b><br/> 
Content type: <%= fileItemTemp.getContentType() %><br/> 
Field name: <%= fileItemTemp.getFieldName() %><br/> 
File name: <%= fileItemTemp %><br/> 
File size: <%= fileItemTemp.getSize() %><br/><br/> 

<b>The uploaded file has been saved successfully.</b><br/>
<% 
					} 
					catch (Exception e){ 
%> 
<b>An error occurred when we tried to save the uploaded file.</b>  <br/>
<% 
					}
				}
			}
		}
	}
}
//Guarda la URI de las ontologias y del alignment. Si son nombres de fichero se convierten a URI
if (modoOntologia1.equals("URL")) {
	uri1 = urlOntologia1;
}
else { 
	uri1 = "file:" + nameArchivoOntologia1;
}

if (modoOntologia2.equals("URL")) {
	uri2 = urlOntologia2;
}
else { 
	uri2 = "file:" + nameArchivoOntologia2;
}

if (modoAlignment.equals("URL")) {
	uriAlignment = urlAlignment;
}
else { 
	uriAlignment = ("file:" + nameArchivoAlignment);
}

session.setAttribute("uriOnt1", uri1);
session.setAttribute("uriOnt2", uri2);
session.setAttribute("uriAlign",uriAlignment);
session.setAttribute("verC", verClases);
session.setAttribute("verP", verPropiedades);
session.setAttribute("verI", verIndividuos);

String dirName = "C:/Temp/"; 
String fileTemp = "";

int numAleatorio = (int)Math.floor(Math.random()*(1000));
String name = "aligngenVisuAlign" + Integer.toString(numAleatorio) + ".rdf";

fileTemp = dirName + name;

session.setAttribute("fileTemp", fileTemp);

if (modoVis.equals("List")) {
%>
	<jsp:forward page = "Lista.jsp" />
<%
}
else if (modoVis.equals("Matrix")) {
%>
	<jsp:forward page = "Matriz.jsp" />
<%	
}
else {
	out.print("Modo de Visualizacion Incorrecto");
}
%>
</body> 
</html> 