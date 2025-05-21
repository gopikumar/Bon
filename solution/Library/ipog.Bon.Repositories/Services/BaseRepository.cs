using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;
using static Dapper.SqlMapper;

namespace ipog.Bon.Repositories.Services
{
    public abstract class BaseRepository
    {
        protected readonly IConfiguration _configuration;
        protected readonly SqlConnection _connection;
        public BaseRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
        public async Task<(int, IEnumerable<T>)> QueryMultipleAsync<T>(string spName, DynamicParameters parameters)
        {
            using (GridReader response = await _connection.QueryMultipleAsync(spName, parameters, commandType: CommandType.StoredProcedure))
            {
                return (response.ReadFirst<int>(), response.Read<T>());
            }
        }
        public async Task<T?> QueryFirstOrDefaultAsync<T>(string spName, DynamicParameters parameters)
        {
            return await _connection.QueryFirstOrDefaultAsync<T>(spName, parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<int> ExecuteAsync(string spName, DynamicParameters parameters)
        {
            return await _connection.ExecuteAsync(spName, parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
