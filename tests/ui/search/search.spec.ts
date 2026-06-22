import { test, expect } from '@playwright/test';

/**
 * Testes E2E de busca no Mercado Livre
  * Cobre fluxos criticos de usuario na camada de UI
   */

   test.describe('Busca de produtos - Mercado Livre', () => {

     test.beforeEach(async ({ page }) => {
         await page.goto('/');
           });

             test('TC-UI-001: busca por termo valido deve exibir resultados', async ({ page }) => {
                 // Arrange
                     const searchTerm = 'notebook';

                         // Act
                             const searchInput = page.locator('input[type="text"]').first();
                                 await searchInput.fill(searchTerm);
                                     await searchInput.press('Enter');

                                         // Assert
                                             await expect(page).toHaveURL(/.*notebook.*/);
                                                 const results = page.locator('[class*="results"]');
                                                     await expect(results).toBeVisible({ timeout: 10000 });
                                                       });

                                                         test('TC-UI-002: pagina inicial deve ter campo de busca visivel', async ({ page }) => {
                                                             // Assert - validacao de elemento critico na home
                                                                 const searchInput = page.locator('input[type="text"]').first();
                                                                     await expect(searchInput).toBeVisible();
                                                                         await expect(searchInput).toBeEnabled();
                                                                           });

                                                                             test('TC-UI-003: titulo da pagina deve conter Mercado Livre', async ({ page }) => {
                                                                                 // Assert - smoke test basico
                                                                                     await expect(page).toHaveTitle(/Mercado Livre/i);
                                                                                       });

                                                                                       });
