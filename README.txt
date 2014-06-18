----------------------------------------------------
----------------------------------------------------
Installation
----------------------------------------------------
----------------------------------------------------
Requirements
----------------------------------------------------

Java Runtime Enviremont version 1.7
Apache Tomcat version 7.0.53

----------------------------------------------------
Deployment 
----------------------------------------------------

Before deploy:

Create the directory to temporary files:
“C:\Temp\”

To use the software with medium- large ontologies, its necessary to modify the maximum number of fields allowed in a form:

Tomcat_Installation_Directory\conf\server.xml

The port settings (default port is 8080)
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443"/>
			   
Modify it like this:
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443"
maxParameterCount="500000" />

Copy the file “Visualizador.war ” into directory:

Tomcat_Installation_Directory\webbapps

Start Tomcat.
----------------------------------------------------
----------------------------------------------------
Usage
----------------------------------------------------
----------------------------------------------------

Index:

You can provide two ontologies and an alignment between the two ontologies.
You must provide the ontologies in the order of declaration in the alignment.
The tool can operate ontologies in RDF an OWL files, and URI´s and alignments in RDF files and URI´s.
You can select your initial display mode (matrix or list of pairs) and decide what components of the ontologies to display (classes, properties and/or individuals).

List view:

You can modify the cell components (element 1, element 2, relation and measure).
You can add new cells (Select the components in the template cell beneath the list and click “Add Cell”).
You can delete various cells (check the cells you want to delete and click “Delete Cells”).
You can save your modified alignment (click “Save Alignment”).
You can switch to Matrix view (click “Matrix”).

Matrix view:

You can modify the cell components (relation and measure).
You can save your modified alignment (click “Save Alignment”).
You can switch to List view (click “List”).
