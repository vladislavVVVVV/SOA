using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApi.Data;
using WebApi.Models;

namespace WebApi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class MenuesController : ControllerBase
    {
        
        private readonly RecipesContext _context;

        public MenuesController(RecipesContext context)
        {
            _context = context;
        }
    
        // GET: api/Menues
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Menue>>> GetMenues()
        {
            return await _context.Menues.ToListAsync();
        }

        // GET: api/Menues/5
        [HttpGet("{id}", Name = "GetMenue")]
        public async Task<ActionResult<Menue>> GetMenue(int id)
        {
            var menue = await _context.Menues
                .FirstOrDefaultAsync(i => i.id == id);

            if (menue == null)
            {
                return NotFound();
            }

            return menue;
        }

        // POST: api/Menues
        [HttpPost]
        public async Task<ActionResult<Menue>> PostMenue(Menue menue)
        {
            _context.Menues.Add(menue);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetMenue", new { id = menue.id }, menue);
        }

        // PUT: api/Menues/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutMenue(int id, Menue menue)
        {
            if (id != menue.id)
            {
                return BadRequest();
            }

            _context.Entry(menue).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Exists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Menues/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Menue>> DeleteMenu(int id)
        {
            var menue = await _context.Menues.FindAsync(id);
            if (menue == null)
            {
                return NotFound();
            }

            _context.Menues.Remove(menue);
            await _context.SaveChangesAsync();

            return menue;
        }
    
        private bool Exists(int id)
        {
            return _context.Menues.Any(e => e.id == id);
        }
    }

}
