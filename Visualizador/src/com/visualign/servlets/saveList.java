package com.visualign.servlets;

import java.io.*;
import java.net.URI;
import java.lang.Exception;

import org.semanticweb.owl.align.AlignmentException;
import org.semanticweb.owl.align.AlignmentVisitor;

import fr.inrialpes.exmo.align.parser.AlignmentParser;
import fr.inrialpes.exmo.align.impl.BasicAlignment;
import fr.inrialpes.exmo.align.impl.renderer.RDFRendererVisitor;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class saveList
 */
@WebServlet("/saveList")
public class saveList extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BasicAlignment alineamiento = new BasicAlignment();

		//Lee los path de los ficheros de las ontologias y del alignment
		String uriAlignment = request.getSession().getAttribute("uriAlign").toString();
		String fileName = request.getSession().getAttribute("fileTemp").toString();
		int n = fileName.lastIndexOf("/");
		int m = fileName.lastIndexOf(".");
		String name = fileName.substring(n+1, m) +".rdf";
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
			
			try {
				alineamiento.addAlignCell(cls1, cls2, relation, measure);
			}
			catch (AlignmentException e) {
				request.getSession().setAttribute("mensaje",uriAlignment);
				String nextJSP = "/errorAligment.jsp";
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
				dispatcher.forward(request,response);
			}
			finally {
			}
			
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
			String nextJSP = "/errorEscAl.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
			dispatcher.forward(request,response);
		}
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
