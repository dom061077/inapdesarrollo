dataSource {

}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
		dataSource {
			pooled = true
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "exito"
		    dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/saie"
        }
    }
    test {
        dataSource {
			pooled = true
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "exito"
		
            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/saie"
        }
    }
    production {
         /*dataSource {
			pooled = true
			driverClassName = "com.mysql.jdbc.Driver"
			username = "inapcom_rootsaie"
			password = "SkibyPomoDom2012"
            dbCreate = "update"
            url = "jdbc:mysql://localhost/inapcom_saie"
			properties {
				maxActive = 50
				maxIdle = 25
				minIdle = 5
				initialSize = 5
				minEvictableIdleTimeMillis = 60000
				timeBetweenEvictionRunsMillis = 60000
				maxWait = 10000
				validationQuery = "select 1"
			}
        }*/
		
		dataSource {
			pooled = true
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "exito"
			//dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:mysql://10.0.0.3/saiecristian"
		}

    }
}
