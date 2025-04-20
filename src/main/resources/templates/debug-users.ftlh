<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Debug - Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>User Database Debug</h1>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Enabled</th>
                    <th>Roles</th>
                    <th>Provider ID</th>
                </tr>
            </thead>
            <tbody>
                <#if users?? && users?size gt 0>
                    <#list users as user>
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.enabled?string('Yes', 'No')}</td>
                            <td>
                                <#if user.roles?? && user.roles?size gt 0>
                                    <#list user.roles as role>
                                        ${role}<#if role_has_next>, </#if>
                                    </#list>
                                <#else>
                                    No roles
                                </#if>
                            </td>
                            <td>${(user.providerId??)?then(user.providerId, 'N/A')}</td>
                        </tr>
                    </#list>
                <#else>
                    <tr>
                        <td colspan="5" class="text-center">No users found in database</td>
                    </tr>
                </#if>
            </tbody>
        </table>

        <a href="/login" class="btn btn-primary">Back to Login</a>
    </div>
</body>
</html>