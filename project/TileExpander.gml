#define TileExpander

window_set_caption('...');
game_end();

u=16;
n=4;

j=parameter_count();
if j<1{
show_message('TileExpander v1.0#Usage: expander.exe [width] [-offset] file1 [file2 [file3 … ]]#width = number of tiles in width (default "16")#-offset = number of pixels to blur (default "-4")#file1 .. = name of source files. If this is a ".txt" document then used as a list of names;#otherwise used as bmp/png/jpg image to process.##Hold F2 anytime to abort!');
exit;}
c=0;t[c]='';
for(i=1;i<=j;i+=1){if keyboard_check_direct(vk_f2)exit;
k=parameter_string(i);
v=string_digits(k);
if string_length(k)<3 if (v=k)or('-'+v=k){
v=real(k);if v>0 u=v else n=-v;
continue;}
if not file_exists(k)continue;
if filename_ext(k)='.txt'{
a=file_text_open_read(k);
while not file_text_eof(a){if keyboard_check_direct(vk_f2)exit;
p=file_text_read_string(a);
file_text_readln(a);
if file_exists(p){
t[c]=p;c+=1;}}
file_text_close(a);
}else{
t[c]=k;
c+=1;}}
for(v=0;v<c;v+=1){if keyboard_check_direct(vk_f2)exit;
r=t[v];
window_set_caption(filename_name(r));
texture_set_interpolation(false);
b=background_add(r,0,0);
w=background_get_width(b);
h=background_get_height(b);
e=w div u;h=h div e;
f=surface_create(e,e);
s=surface_create(w*2,w);
for(i=0;i<u;i+=1){
x1=i*e;x2=x1+x1;
for(j=0;j<h;j+=1){
y1=j*e;y2=y1+y1;
surface_set_target(f);
texture_set_interpolation(false);
draw_background_part(b,x1,y1,e,e,0,0);
surface_set_target(s);
texture_set_interpolation(true);
for(k=0;k<n;k+=1){if keyboard_check_direct(vk_f2)exit;
m=(e*2-k*2);
draw_surface_stretched(f,x2+k,y2+k,m,m);
}}}
surface_reset_target();
surface_save(s,r+'.png');
background_delete(b);
surface_free(f);
surface_free(s);
}
