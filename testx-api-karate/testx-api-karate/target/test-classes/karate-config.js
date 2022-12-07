function fn() {
    karate.configure('connectTimeout', 90000);
    karate.configure('readTimeout', 90000);
    var env = karate.properties['Env']

    var config = {
        env: env,
        certificates: {keyStore: "classpath:certificates/karate-dev-team.pfx", keyStorePassword: "karateApp", keyStoreType: "pkcs12"}
    };
    return config;
}


