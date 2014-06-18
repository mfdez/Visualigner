package com.visualign.servlets;

import java.util.*;
import java.io.*;
import java.net.URI;
import java.lang.Exception;

import org.semanticweb.owl.align.AlignmentException;
import org.semanticweb.owl.align.AlignmentVisitor;

import fr.inrialpes.exmo.align.parser.AlignmentParser;
import fr.inrialpes.exmo.align.impl.BasicAlignment;
import fr.inrialpes.exmo.align.impl.renderer.RDFRendererVisitor;

import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntResource;
import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntProperty;
import com.hp.hpl.jena.ontology.Individual;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.util.iterator.ExtendedIterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class saveMatrix
 */
@WebServlet("/saveMatrix")
public class saveMatrix extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BasicAlignment alineamiento = new BasicAlignment();
		String uri1 = null;
		String uri2 = null;
		String uriAlignment = "";
		String verClases = null;
		String verPropiedades = null;
		String verIndividuos = null;

		//Lee los path de los ficheros de las ontologias y del alignment
		uri1 = request.getSession().getAttribute("uriOnt1").toString();
		uri2 = request.getSession().getAttribute("uriOnt2").toString();
		uriAlignment = request.getSession().getAttribute("uriAlign").toString();
		verClases = request.getSession().getAttribute("verC").toString();
		verPropiedades = request.getSession().getAttribute("verP").toString();
		verIndividuos = request.getSession().getAttribute("verI").toString();

		String fileName = request.getSession().getAttribute("fileTemp").toString();
		int n = fileName.lastIndexOf("/");
		int m = fileName.lastIndexOf(".");
		String name = fileName.substring(n+1, m) +".rdf";
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
			request.getSession().setAttribute("mensaje",uriAlignment);
			String nextJSP = "/errorAligment.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
			dispatcher.forward(request,response);
		}
		finally {
		}

		//borrar las celdas del alignment
		alineamiento.deleteAllCells();

		//Obtiene uris de las ontologias
		String uriOnto1 = alineamiento.getOntology1URI().toString();
		String uriOnto2 = alineamiento.getOntology2URI().toString();

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

				if (relation != "") {
					Double measure = Double.parseDouble(request.getParameter("measure" + String.valueOf((j * (longitudELemOnt1)) + i)));
					URI cls1 = URI.create(elementOnt1);
					URI cls2 = URI.create(elementOnt2);
					try {
						alineamiento.addAlignCell(cls1, cls2, relation, measure);
					} catch (AlignmentException e) {
						request.getSession().setAttribute("mensaje",uriAlignment);
						String nextJSP = "/errorAligment.jsp";
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
						dispatcher.forward(request,response);
					}
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
			String nextJSP = "/errorEscAl.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
			dispatcher.forward(request,response);
		}

		//Devolvemos el fichero generado
		response.setContentType("application/download");
		response.setHeader("Content-Disposition", "attachement;filename="+name);
		try {
			FileInputStream archivo = new FileInputStream(fileName); 
			int longitud = archivo.available();
			byte[] datos = new byte[longitud];
			archivo.read(datos);
			archivo.close();

			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(datos);
			ouputStream.flush();
			ouputStream.close();

		} catch (Exception e) {
			String nextJSP = "/errorEscAl.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
			dispatcher.forward(request,response);
		}
	}

}
