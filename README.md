
## Developer tips

#### Using Postman

To access endpoints you may edit collection to configure Authentication and Authorization.
On **Edit Collection** window in **Authentication** tab:
- **TYPE**=**Bearer token**
- **Token**=**{{access_token}}**

Then, on tab **Tests** add code below:
```javascript
var response = pm.response.json();
if (typeof(response) === "object" && response !== null) {
    if ("access_token" in response)
        pm.environment.set("access_token", response.access_token);
    if ("refresh_token" in response)
        pm.environment.set("refresh_token", response.refresh_token);
}
```
In Sign Up, Sign In and Refresh token endpoints **Authorization** must be **No Auth**.
In all the others must be **Inherit auth from parent**.
