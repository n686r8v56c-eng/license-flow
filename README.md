# License Flow

React + Vite + Supabase + Cloudflare Pages. Email login and signup, user-scoped records, licenses, schedule, milestones, materials, scores, time, expenses, income models and research.

## Setup
1. Create a Supabase project, open SQL Editor, run `supabase.sql`. This adds only a new table and its RLS policy; it does not delete existing app data.
2. Copy `.env.example` to `.env`, fill `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` (publishable/anon key, **not** service role).
3. `npm install`, `npm run dev` for local development, `npm run build` to verify.
4. In Supabase Authentication settings, configure email confirmation and Site URL/redirect URLs for your deployed domain.
5. Cloudflare Pages: connect repository, build command `npm run build`, output directory `dist`, add both `VITE_...` environment variables.

## Notes
- Existing HTML localStorage data is **not** automatically migrated. Keep the old JSON backup; do not delete the original prototype or database.
- Linked lecture start/end events are derived from the original lecture record, so dates update automatically and duplicates are not inserted. Deleting a linked event unchecks its sync flag without deleting the lecture. Deleting the lecture removes its linked events.
- Time records are manually entered in minutes. Focus Flow / Memory Lab / 90 Day Flow integration is not yet implemented. KPI export/import and file uploads are future work.
- Costs entered on materials and standalone expenses are summed. Avoid recording the same expense twice.
- `license_flow_items` uses row-level security per authenticated user.

## Connected Supabase project
The public Supabase URL and publishable key are provided in `.env.production` for Cloudflare Pages builds. These are public client credentials, **not** service-role secrets.

Cloudflare Pages: framework Vite, build command `npm run build`, output directory `dist`. Optionally set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` in Cloudflare project environment variables (production and preview).

Run `supabase.sql` once in the project's SQL Editor before using data features. Review existing tables/policies before running SQL. The script does not delete rows, but it replaces a policy of the same name if one already exists.

Supabase Auth URL configuration: set Site URL to the deployed Cloudflare Pages domain and add any preview URLs as Redirect URLs as needed. If email confirmation is enabled, verify emails before logging in.
