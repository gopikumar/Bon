using Dapper;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Data;

namespace ipog.Bon.Repositories.Services
{
    public abstract class BaseRepository
    {

        private readonly IConfiguration _configuration;
        private readonly string[] _readConnections;
        private readonly string _writeConnection;
        private static int _readIndex = 0;

        protected BaseRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _writeConnection = _configuration.GetConnectionString("WriteConnection");
            _readConnections = configuration.GetSection("DatabaseReplicas:ReadConnections").Get<string[]>()
                           ?? throw new InvalidOperationException("Read connections are not configured.");

        }

        private SqlConnection GetReadConnection()
        {
            int index = Interlocked.Increment(ref _readIndex) % _readConnections.Length;
            return new SqlConnection(_readConnections[index]);
        }

        private SqlConnection GetWriteConnection()
        {
            return new SqlConnection(_writeConnection);
        }

        // Use for read operations
        protected async Task<(int, IEnumerable<T>)> QueryMultipleAsync<T>(string spName, DynamicParameters parameters)
        {
            using var connection = GetReadConnection();
            await connection.OpenAsync();
            using var response = await connection.QueryMultipleAsync(spName, parameters, commandType: CommandType.StoredProcedure);
            return (response.ReadFirst<int>(), response.Read<T>());
        }

        protected async Task<T?> QueryFirstOrDefaultAsync<T>(string spName, DynamicParameters parameters)
        {
            using var connection = GetReadConnection();
            await connection.OpenAsync();
            return await connection.QueryFirstOrDefaultAsync<T>(spName, parameters, commandType: CommandType.StoredProcedure);
        }

        // Use for write operations
        protected async Task<int> ExecuteAsync(string spName, DynamicParameters parameters)
        {
            using var connection = GetWriteConnection();
            await connection.OpenAsync();
            return await connection.ExecuteAsync(spName, parameters, commandType: CommandType.StoredProcedure);
        }
    }

}
