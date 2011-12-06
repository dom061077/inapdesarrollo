package com.educacion.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
 
/**
 * Indicates that a service method (or entire controller) requires
 * being called using POST.
 */
@Target({ElementType.FIELD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SecuredRequest {
 
  /**
   * Whether to display an error or be silent (default).
   * @return  <code>true</code> if an error should be shown
   */
  boolean secured() default false;
}