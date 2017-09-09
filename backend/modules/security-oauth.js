const jwt = require('express-jwt');
const rsaValidation = require('auth0-api-jwt-rsa-validation');

// We’ll create a middleware function to validate the access token when our API is called
// Note that the audience field is the identifier you gave to your API.
var jwtCheck = jwt({
    secret: jwks.expressJwtSecret({
        cache: true,
        rateLimit: true,
        jwksRequestsPerMinute: 5,
        jwksUri: "https://cpfairapp.eu.auth0.com/.well-known/jwks.json"
    }),
    audience: 'http://localhost:3000/',
    issuer: "https://cpfairapp.eu.auth0.com/",
    algorithms: ['RS256']
});

securityConfiguration = (app) => {
    // Enable the use of the jwtCheck middleware in all of our routes
    app.use(jwtCheck);

    // If we do not get the correct credentials, we’ll return an appropriate message
    app.use(function (err, req, res, next) {
    if (err.name === 'UnauthorizedError') {
        res.status(401).json({message:'Missing or invalid token'});
    }
    });
}

module.exports.securityConfiguration = securityConfiguration;