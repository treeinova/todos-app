using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using TodoListApi.Models;
using TodoListApi.Services;

namespace TodoListApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TodoController : ControllerBase
    {
        private readonly ILogger<TodoController> _logger;
        private TodoService _todoService;

        public TodoController(
            ILogger<TodoController> logger,
            TodoService todoService)
        {
            _logger = logger;
            _todoService = todoService;
        }

        [HttpGet]
        public ActionResult Get()
        {
            return Ok(_todoService.Get());
        }

        [HttpGet("{id:int}")]
        public ActionResult Get(int id)
        {
            return Ok(_todoService.Get(id));
        }

        [HttpPost]
        public ActionResult Post([FromBody] Todo todo)
        {
            return Ok(_todoService.Insert(todo));
        }

        [HttpPut("{id:int}")]
        public ActionResult Put(int id, [FromBody] Todo todo)
        {
            todo.Id = id;
            return Ok(_todoService.Update(todo));
        }

        [HttpPut("{id:int}/concluido")]
        public ActionResult Concluido(int id)
        {
            return Ok(_todoService.Concluido(id));
        }

        [HttpDelete("{id:int}")]
        public ActionResult Delete(int id)
        {
            return Ok(_todoService.Delete(id));
        }
    }
}
