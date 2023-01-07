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

       
        [HttpGet]
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
            else
            {
                return BadRequest();
            }
        }

        [HttpGet]
        [Route("{id:int}")]
        public async Task<IActionResult> GetObject([FromRoute] int id, string ObjectType)
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
                var user = await dbContext.Devices.FindAsync(id);
                if (user == null)
                {
                    return NotFound();
                }
                return Ok(user); 
            }
            else
            { 
                return BadRequest();
            }

        } 

        [HttpPost("AddDevice")]
        public async Task<IActionResult> AddDevice(AddDeviceRequest addDeviceRequest)
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
        public async Task<IActionResult> AddUser(AddUserRequest addUserRequest)
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
                Salt= addUserRequest.Salt,
                Role_id= addUserRequest.Role_id
            };

            await dbContext.Users.AddAsync(newUser);
            await dbContext.SaveChangesAsync();

            return Ok(newUser);
        }

        [HttpPut]
        [Route("{id:int}")]
        public async Task<IActionResult> UpdateDevice([FromRoute] int id, UpdateDeviceRequest updateDeviceRequest)
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

        [HttpDelete]
        [Route("{id:int}")]
        public async Task<IActionResult> DeleteDevice([FromRoute] int id, string ForDelete)
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
            else
            {
                return BadRequest();
            }

            return NotFound();
        }
        
    }
}
