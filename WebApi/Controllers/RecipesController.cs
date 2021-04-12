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
    public class RecipesController : ControllerBase
    {

        private readonly RecipesContext _context;

        public RecipesController(RecipesContext context)
        {
            _context = context;
        }
    
        // GET: api/Recipes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Recipe>>> GetRecipess()
        {
            return await _context.Recipes.ToListAsync();
        }

        // GET: api/Recipes/5
        [HttpGet("{id}", Name = "GetRecipes")]
        public async Task<ActionResult<Recipe>> GetRecipes(int id)
        {
            var Recipes = await _context.Recipes
                .FirstOrDefaultAsync(i => i.id == id);

            if (Recipes == null)
            {
                return NotFound();
            }

            return Recipes;
        }

        // POST: api/Recipes
        [HttpPost]
        public async Task<ActionResult<Recipe>> PostRecipes(Recipe recipe)
        {
            _context.Recipes.Add(recipe);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRecipes", new { id = recipe.id }, recipe);
        }

        // PUT: api/Recipes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRecipes(int id, Recipe recipe)
        {
            if (id != recipe.id)
            {
                return BadRequest();
            }

            _context.Entry(recipe).State = EntityState.Modified;

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

        // DELETE: api/Recipes/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Recipe>> DeleteRecipes(int id)
        {
            var recipe = await _context.Recipes.FindAsync(id);
            if (recipe == null)
            {
                return NotFound();
            }

            _context.Recipes.Remove(recipe);
            await _context.SaveChangesAsync();

            return recipe;
        }
    
        private bool Exists(int id)
        {
            return _context.Recipes.Any(e => e.id == id);
        }
    }
}
