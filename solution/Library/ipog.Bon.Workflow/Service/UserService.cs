using ipog.Bon.Entity;
using ipog.Bon.Entity.Users;
using ipog.Bon.Model;
using ipog.Bon.Model.Users;
using ipog.Bon.Repositories.IServices;
using ipog.Bon.Workflow.IService;
using ipog.Bon.Workflow.Mapping;

namespace ipog.Bon.Workflow.Service
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapping _mapper;
        public UserService(IUserRepository iUserRepository, IMapping mapper)
        {
            _userRepository = iUserRepository;
            _mapper = mapper;
        }
        public async Task<ResponseModelCollection> Get()
        {
            if (await _userRepository.Get() is (int,IEnumerable<User>) item)
            {
                if (item.Item1.Equals(0))
                {
                    return new ResponseModelCollection()
                    {
                        Code = 404,
                        Success = false,
                        Message = "Data not found"
                    };
                }
                if (await _mapper.CreateMap<UserModelCollection, List<User>>(item.Item2.ToList()) is UserModelCollection userModel)
                {
                    return new ResponseModelCollection()
                    {
                        Record = new ResultModel()
                        {
                            Count = item.Item1,
                            Data = userModel
                        }
                    };
                }
            }
            return default;
        }
        public async Task<ResponseModelCollection> Get(Pagination pagination)
        {
            if (await _userRepository.Get(pagination) is (int, IEnumerable<User>) item)
            {
                if (await _mapper.CreateMap<UserModelCollection, List<User>>(item.Item2.ToList()) is UserModelCollection userModel)
                {
                    return new ResponseModelCollection()
                    {
                        Record = new ResultModel()
                        {
                            Count = item.Item1,
                            Data = userModel
                        }
                    };
                }
            }
            return default;
        }
        public async Task<User> Find(Guid uid)
        {
            return await _userRepository.Find(uid);
        }
        public async Task<User> Add(User model)
        {
            return await _userRepository.Add(model);
        }
        public async Task<User> Update(User model)
        {
            return await _userRepository.Update(model);
        }
        public async Task<int> Delete(Guid uid)
        {
            return await _userRepository.Delete(uid);
        }
        public async Task<int> IsActive(Guid uid, bool isActive)
        {
            return await _userRepository.IsActive(uid, isActive);
        }

    }
}
