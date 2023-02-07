using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VendingMachineAPI.Data;
using VendingMachineAPI.Models;

namespace VendingMachineAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VendingMachineController : Controller
    {
        private readonly VendingMachineAPIDbContext dbContext;

        public VendingMachineController(VendingMachineAPIDbContext dbContext)
        {
            this.dbContext = dbContext;
        }

       
        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll(string ObjectsType)
        {
            if (ObjectsType.ToLower() == "users")
            {
                return Ok(await dbContext.Users.ToListAsync());
            }
            else if (ObjectsType.ToLower() == "devices")
            {
                return Ok(await dbContext.Devices.ToListAsync());
            }
            else if (ObjectsType.ToLower() == "events")
            {
                return Ok(await dbContext.Events.ToListAsync());
            }
            else if (ObjectsType.ToLower() == "roles")
            {
                return Ok(await dbContext.Roles.ToListAsync());
            }
            else if (ObjectsType.ToLower() == "login")
            {
                return Ok(await dbContext.Login.ToListAsync());
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpGet("GetOne")]
        public async Task<IActionResult> GetObject(int id, string ObjectType)
        {
            if (ObjectType.ToLower() == "device")
            {
                var device = await dbContext.Devices.FindAsync(id);
                if (device == null)
                {
                    return NotFound();
                }
                return Ok(device);
            }
            else if (ObjectType.ToLower() == "user")
            {
                var user = await dbContext.Users.FindAsync(id);
                if (user == null)
                {
                    return NotFound();
                }
                return Ok(user); 
            }
            else if (ObjectType.ToLower() == "role")
            {
                var role = await dbContext.Roles.FindAsync(id);
                if (role == null)
                {
                    return NotFound();
                }
                return Ok(role);
            }
            else if (ObjectType.ToLower() == "login")
            {
                var login = await dbContext.Login.FindAsync(id);
                if (login == null)
                {
                    return NotFound();
                }
                return Ok(login);
            }
            else if (ObjectType.ToLower() == "event")
            {
                var selectedEvent = await dbContext.Login.FindAsync(id);
                if (selectedEvent == null)
                {
                    return NotFound();
                }
                return Ok(selectedEvent);
            }
            else
            { 
                return BadRequest();
            }
        }

        [HttpGet("UniqueEmail")]
        public async Task<IActionResult> UniqueEmail(string email)
        {
            User user = await dbContext.Users.Where(p => p.Email == email).FirstOrDefaultAsync(); 
            if (user != null)
            { 
                return BadRequest(user); 
            }
            else
            {
                return Ok();
            }
        }

        [HttpGet("LoginRequest")]
        public async Task<IActionResult> LoginRequest(string email, string password)
        {
            User user = await dbContext.Users.Where(p => p.Email == email && p.Password == password).FirstOrDefaultAsync();
            if (user == null)
            {
                return NotFound();
            }
            else
            {
                return Ok(user);
            }
        }

        [HttpPost("AddDevice")]
        public async Task<IActionResult> AddDevice(DeviceRequest addDeviceRequest)
        {
            List<Device> devicesList = await dbContext.Devices.ToListAsync(); 
            int numberOfElements = devicesList.Count;
            int newId; 
            if(numberOfElements > 0)
            {
                newId = devicesList[numberOfElements - 1].Device_ID +1; 
            }
            else
            {
                newId = 0;
            }

            var newDevice = new Device()
            {
                Device_ID = newId,
                Lat = addDeviceRequest.Lat,
                Long = addDeviceRequest.Long,
                Stock = addDeviceRequest.Stock,
                Price = addDeviceRequest.Price,
                Active = addDeviceRequest.Active,
            }; 

            await dbContext.Devices.AddAsync(newDevice);
            await dbContext.SaveChangesAsync(); 

            return Ok(newDevice);
        }
         
        [HttpPost("AddUser")]
        public async Task<IActionResult> AddUser(UserRequest addUserRequest)
        {
            List<User> usersList = await dbContext.Users.ToListAsync();
            int numberOfElements = usersList.Count;
            int newId;
            if (numberOfElements > 0)
            {
                newId = usersList[numberOfElements - 1].User_ID + 1;
            }
            else
            {
                newId = 0;
            }

            var newUser = new User()
            {
                User_ID = newId,
                First_name = addUserRequest.First_name,
                Last_name= addUserRequest.Last_name,
                Email= addUserRequest.Email,
                Password= addUserRequest.Password,
                Role_id= addUserRequest.Role_id
            };

            await dbContext.Users.AddAsync(newUser);
            await dbContext.SaveChangesAsync();

            return Ok(newUser);
        }

        [HttpPost("AddRole")]
        public async Task<IActionResult> AddRole(string description)
        {
            List<Role> rolesList = await dbContext.Roles.ToListAsync();
            int numberOfElements = rolesList.Count;
            int newId;
            if (numberOfElements > 0)
            {
                newId = rolesList[numberOfElements - 1].Role_ID + 1;
            }
            else
            {
                newId = 0;
            }

            var newRole = new Role()
            {
                Role_ID = newId,
                Description = description
            };

            await dbContext.Roles.AddAsync(newRole);
            await dbContext.SaveChangesAsync();

            return Ok(newRole);
        }

        [HttpPost("AddLogin")]
        public async Task<IActionResult> AddLogin(int user_id,  DateTime date_time)
        {
            List<Login> loginsList = await dbContext.Login.ToListAsync();
            int numberOfElements = loginsList.Count;
            int newId;
            if (numberOfElements > 0)
            {
                newId = loginsList[numberOfElements - 1].Login_ID + 1;
            }
            else
            {
                newId = 0;
            }

            var newLogin = new Login()
            {
                Login_ID = newId,
                User_id = user_id,
                Date_time = date_time
            };

            await dbContext.Login.AddAsync(newLogin);
            await dbContext.SaveChangesAsync();

            return Ok(newLogin);
        }

        [HttpPost("AddEvent")]
        public async Task<IActionResult> AddEvent(EventRequest eventRequest)
        {
            List<Event> eventsList = await dbContext.Events.ToListAsync();
            int numberOfElements = eventsList.Count;
            int newId;
            if (numberOfElements > 0)
            {
                newId = eventsList[numberOfElements - 1].Event_ID + 1;
            }
            else
            {
                newId = 0;
            }

            var newEvent = new Event()
            {
                Event_ID = newId,
                User_id = eventRequest.User_id,
                Device_id = eventRequest.Device_id,
                Date_time = eventRequest.Date_time
            };

            await dbContext.Events.AddAsync(newEvent);
            await dbContext.SaveChangesAsync();

            return Ok(newEvent);
        }
        
        [HttpPut("UpdateDevice")]
        public async Task<IActionResult> UpdateDevice(int id, DeviceRequest updateDeviceRequest)
        {
            var device = await dbContext.Devices.FindAsync(id);
            if (device == null)
            {
                return NotFound();
            }
            else
            {
                device.Lat= updateDeviceRequest.Lat;
                device.Long= updateDeviceRequest.Long;
                device.Stock= updateDeviceRequest.Stock;
                device.Price= updateDeviceRequest.Price;
                device.Active= updateDeviceRequest.Active;

                await dbContext.SaveChangesAsync(); 
                return Ok(device);
            }
        }

        [HttpPut("UpdateUser")]
        public async Task<IActionResult> UpdateUser(int id, UserRequest updateUserRequest)
        {
            var user = await dbContext.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            else
            {
                user.First_name = updateUserRequest.First_name;
                user.Last_name = updateUserRequest.Last_name;
                user.Email= updateUserRequest.Email;
                user.Password= updateUserRequest.Password;
                user.Role_id= updateUserRequest.Role_id;


                await dbContext.SaveChangesAsync();
                return Ok(user);
            }
        }


        [HttpPut("UpdateEvent")]
        public async Task<IActionResult> UpdateEvent(int id, EventRequest updateEventRequest)
        {
            var selectedevent = await dbContext.Events.FindAsync(id);
            if (selectedevent == null)
            {
                return NotFound();
            }
            else
            {
                selectedevent.Date_time = updateEventRequest.Date_time;
                selectedevent.Device_id = updateEventRequest.Device_id;
                selectedevent.User_id= updateEventRequest.User_id;

                await dbContext.SaveChangesAsync();
                return Ok(selectedevent);
            }
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteDevice(int id, string ForDelete)
        {
            if (ForDelete.ToLower() == "device")
            {
                var ObjectForDelete = await dbContext.Devices.FindAsync(id);
                if (ObjectForDelete != null)
                {
                    dbContext.Devices.Remove(ObjectForDelete);
                    await dbContext.SaveChangesAsync();
                    return Ok(ObjectForDelete);
                }
            }
            else if (ForDelete.ToLower() == "user")
            {
                var ObjectForDelete = await dbContext.Users.FindAsync(id);
                if (ObjectForDelete != null)
                {
                    dbContext.Users.Remove(ObjectForDelete);
                    await dbContext.SaveChangesAsync();
                    return Ok(ObjectForDelete);
                }
            }
            else if (ForDelete.ToLower() == "role")
            {
                var ObjectForDelete = await dbContext.Roles.FindAsync(id);
                if (ObjectForDelete != null)
                {
                    dbContext.Roles.Remove(ObjectForDelete);
                    await dbContext.SaveChangesAsync();
                    return Ok(ObjectForDelete);
                }
            }
            else if (ForDelete.ToLower() == "login")
            {
                var ObjectForDelete = await dbContext.Login.FindAsync(id);
                if (ObjectForDelete != null)
                {
                    dbContext.Login.Remove(ObjectForDelete);
                    await dbContext.SaveChangesAsync();
                    return Ok(ObjectForDelete);
                }
            }
            else if (ForDelete.ToLower() == "event")
            {
                var ObjectForDelete = await dbContext.Events.FindAsync(id);
                if (ObjectForDelete != null)
                {
                    dbContext.Events.Remove(ObjectForDelete);
                    await dbContext.SaveChangesAsync();
                    return Ok(ObjectForDelete);
                }
            }
            else
            {
                return BadRequest();
            }

            return NotFound();
        }

    }
}
