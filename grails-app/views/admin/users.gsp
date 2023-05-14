<!doctype html>
<html lang="en">

<head>
    %{--    <meta name="layout" content="mymain">--}%
    <title>Link Sharing - Admin</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <asset:javascript src="usersJS"></asset:javascript>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>

<body>
<g:render template="/_templates/navbar" model="page: 'admin'"></g:render>
<div class="container pt-4 mt-4 pb-4 mb-4">
    <table id="allUsersTable" class="table-striped table-hover">
        <thead>
        <tr >
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Firstname</th>
            <th>Lastname</th>
            <th>Active</th>
            <th >Manage</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${allUsersList}" var="userObj">
            <tr>
                <td>${userObj.id}</td>
                <td>${userObj.username}</td>
                <td>${userObj.email}</td>
                <td>${userObj.firstName}</td>
                <td>${userObj.lastName}</td>
                <g:if test="${userObj.isActive}">
                    <td id="isActive_${userObj.username}">Yes</td>
                </g:if>
                <g:else>
                    <td id="isActive_${userObj.username}">No</td>
                </g:else>
                <td>
                    <g:if test="${userObj.isActive}">
                        <button id="changeUserStatusBtn_${userObj.username}" class="btn btn-link" onclick="changeUserStatus('${userObj.username}')">Deactivate</button>
                    </g:if>
                    <g:else>
                        <button id="changeUserStatusBtn_${userObj.username}" class="btn btn-link" onclick="changeUserStatus('${userObj.username}')">Activate</button>
                    </g:else>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>
</body>

</html>
