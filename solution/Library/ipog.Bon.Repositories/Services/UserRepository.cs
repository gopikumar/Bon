using Dapper;
using ipog.Bon.Entity;
using ipog.Bon.Entity.Tables;
using ipog.Bon.Repositories.IServices;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public class UserRepository : IUserRepository
    {
        private readonly IConfiguration _configuration;
        private readonly SqlConnection _connection;
        public UserRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
       
        public async Task<(int, IEnumerable<User>)> Get(Pagination pagination)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "All",
                    orderBy = pagination.OrderBy,
                    sortBy = pagination.SortBy,
                });
            using (GridReader response = await _connection.QueryMultipleAsync("sp_UserGet", parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<User>());
            }
        }
      
        public async Task<(int, IEnumerable<User>)> Get(FilterPagination pagination)
        {
            using (GridReader response = await _connection.QueryMultipleAsync("sp_UserGet",
                PaginationFilter.GetPaginationParameters(pagination), commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<User>());
            }
        }
      
        public async Task<User?> Find(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Get",
                    uid
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<User?> Add(User model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Add",
                    name = model.Name,
                    lastName = model.LastName,
                    password = model.Password,
                    email = model.Email,
                    mobile = model.Mobile,
                    roleId = model.RoleId,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_User", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<User?> Update(User model)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Update",
                    uId = model.UId,
                    name = model.Name,
                    lastName = model.LastName,
                    password = model.Password,
                    email = model.Email,
                    mobile = model.Mobile,
                    roleId = model.RoleId,
                    actionBy = model.ActionBy,
                    isActive = model.IsActive
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_User", parameters, commandType: CommandType.StoredProcedure);
        }
     
        public async Task<int> Delete(Guid uid)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Delete",
                    uid
                });
            return await _connection.ExecuteAsync("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }
      
        public async Task<User?> IsActive(Guid uid, bool isActive)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "IsActive",
                    uid,
                    isActive
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_UserById", parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<string?> EmailValidation(Guid? uid, string email)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Email",
                    uid,
                    email
                });
            return await _connection.QueryFirstOrDefaultAsync<string>("sp_UserValidation", parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<string?> MobileValidation(Guid? uid, string mobile)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "Mobile",
                    uid,
                    mobile
                });
            return await _connection.QueryFirstOrDefaultAsync<string>("sp_UserValidation", parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<User?> Validation(Login request)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "employee",
                    username = request.UserName,
                    password = request.Password
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_Login", parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<User?> UpdatePassword(UpdatePassword request)
        {
            DynamicParameters parameters = new(
                new
                {
                    action = "updatepassword",
                    username = request.UserName,
                    password = request.Password,
                    newpassword = request.NewPassword
                });
            return await _connection.QueryFirstOrDefaultAsync<User>("sp_Login", parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
