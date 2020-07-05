using System;
using System.Collections.Generic;
using System.Linq;
using DCurdApi.Model;
using Microsoft.AspNetCore.Mvc;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace DCurdApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConController : ControllerBase

    {
        private readonly ContractRepository contractRepository;

        public ConController()
        {
            contractRepository = new ContractRepository();

        }

        [Route("~/api/GetAllContract")]
        [HttpGet]
        public IEnumerable<Contract> GetAllContract()
        {
            return contractRepository.GetAll();
        }

        [Route("~/api/GetContract/{id}")]
        [HttpGet]
        public Contract GetContract(int id)
        {
            return contractRepository.GetById(id);
        }

        [Route("~/api/CreateContract")]
        [HttpPost]
        public void CreateContract([FromQuery]Contract con)
        {
            if (ModelState.IsValid)
                contractRepository.Add(con);
        }

        [Route("~/api/UpdateContract/{id}")]
        [HttpPut]
        public void UpdateContract(int id, [FromQuery]Contract con)
        {
            if (ModelState.IsValid)
                contractRepository.Update(id, con);
        }

        [Route("~/api/DeleteContract/{id}")]
        [HttpDelete]
        public void DeleteContract(int id)
        {
            contractRepository.DeleteById(id);
        }
        /*
        // GET: api/<controller>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        [HttpPost]
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
        */
    }
}
