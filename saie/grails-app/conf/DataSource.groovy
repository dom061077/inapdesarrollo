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
			password = ""
		
            dbCreate = "create-drop" // one of 'create', 'create-drop','update'
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
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:file:prodDb;shutdown=true"
        }
    }
}
