watch:
	dart run build_runner watch --delete-conflicting-outputs

fbuild:
	dart run build_runner build --delete-conflicting-outputs

runfunc:
	supabase functions serve --env-file supabase/.env