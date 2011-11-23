package com.educacion.annotations;

import java.util.List;
import java.util.ArrayList;
import org.codehaus.groovy.grails.commons.GrailsControllerClass;
import java.lang.reflect.Method;

public class MarkedRequestUtil{
	
	public List  getRequests(GrailsControllerClass obj){
		Class<?> clazz = obj.getClass();
		ArrayList requests = new ArrayList();
		try{
			Method m = clazz.getMethod("myMeth");
			Requestmark annotation = clazz.getAnnotation(Requestmark.class);
			if(annotation != null){
					System.out.println ("TIENE UNA ETIQUETA DE MARCA: "+obj.getName());
					requests.add(obj);
			}else
				System.out.println ("NOOOO TIENE UNA ETIQUETA DE MARCA: "+obj.getName());
		}catch (NoSuchMethodException exc){
			
		}
		return requests;
	}
	
}

