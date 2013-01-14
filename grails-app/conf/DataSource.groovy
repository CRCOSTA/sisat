dataSource {
    pooled = true
    username = "root"
    password = "root"
    //username = "crcostaassiste"
    //password = "crcosta2011"
    driverClassName = "com.mysql.jdbc.Driver"
     url = "jdbc:mysql://127.0.0.1:3306/crcdb?autoreconnect=true"
     //url = "jdbc:mysql://mysql.crcostaassistencia.com.br/crcostaassiste?autoreconnect=true"

  

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
			dbCreate = "update" // one of 'create', 'create-drop','update'			
			properties {
				maxActive = 20
				maxIdle = 3
				maxIdle = 1
				initialSize = 1
				minEvictableIdleTimeMillis = 60000
				timeBetweenEvictionRunsMillis = 60000
				maxWait = 10000
				validationQuery = "/* ping */"
			 }
		}
	}
    production {
        dataSource {
            pooled = true
            dbCreate = "update"   
			url = "jdbc:mysql://mysql.crcostaassistencia.com.br/crcostaassiste?autoreconnect=true"

             properties {
				username = "crcostaassiste"
				password = "crcosta2011"
                maxActive = 5
                maxIdle = 3
                minIdle = 1
                initialSize = 1
                minEvictableIdleTimeMillis = 60000
                timeBetweenEvictionRunsMillis = 60000
                maxWait = 10000
                validationQuery = "/* ping */"
            }

        }
    }
}